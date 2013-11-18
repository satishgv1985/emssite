using JntuBusinessLogic.EFModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace JntuCollegeEMS.college.upload
{
    public partial class UploadDForm : System.Web.UI.Page
    {
        static public short absentMarks = -1;
        static public short hoursAfterStartTime = 4;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void rcbNotification_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            rcbBranches.ClearSelection();
            rcbExaminationSubjects.ClearSelection();
            tdStudents.Visible = false;
            rbUpload.Enabled = false;
        }

        protected void rcbExaminationSubjects_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            tdStudents.Visible = true;
            rbUpload.Enabled = true;
        }

        protected void rcbBranches_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            lblMessage.Visible = false;
            tdStudents.Visible = false;
            rbUpload.Enabled = false;
            using (JNTUAEMSEntities entities = new JNTUAEMSEntities())
            {
                short eNID = Convert.ToInt16(rcbNotification.SelectedValue);
                short bID = Convert.ToInt16(rcbBranches.SelectedValue);

                var currentExamSubjects = (from ens in entities.ExamNotificationSubjects
                                           join subs in entities.Subjects on ens.SubjectID equals subs.SubjectID
                                           where
                                           ens.ExamNotificationID == eNID
                                           && subs.BranchID == bID
                                           && ens.StartTime != null
                                           select new
                                           {
                                               SubjectID = subs.SubjectID,
                                               SubjectName = subs.SubjectName,
                                               StartTime = ens.StartTime
                                           });

                rcbExaminationSubjects.Items.Clear();

                foreach (var item in currentExamSubjects)
                {
                    DateTime st = Convert.ToDateTime(item.StartTime);

                    if (DateTime.Now > st.AddHours(1) && DateTime.Now < st.AddHours(hoursAfterStartTime))
                        rcbExaminationSubjects.Items.Add(new RadComboBoxItem(item.SubjectName, item.SubjectID + ""));
                }
            }
        }

        protected void rbUpload_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "Data Saved Successfully. Please select another Branch and Subject to Enter again.";
            lblMessage.Visible = true;

            short eNID = Convert.ToInt16(rcbNotification.SelectedValue);
            int subID = Convert.ToInt32(rcbExaminationSubjects.SelectedValue);
            short colID = Convert.ToInt16(Session["CollegeID"]);

            using (JNTUAEMSEntities entities = new JNTUAEMSEntities())
            {
                //Clears all the existing data for absent students

                var studentsIDs = (from sem in entities.StudentExternalMarks
                                  join ssr in entities.StudentSubjectRegistrations on sem.SubjectID equals ssr.SubjectID
                                  where sem.ExamNotificationID == eNID
                                  && sem.SubjectID == subID
                                  && sem.ExternalMarks == absentMarks
                                  && ssr.ExamCenterCollegeID==colID
                                  select sem).Distinct();
                                

                //var stIDs = from sem in entities.StudentExternalMarks
                //            join st in entities.Students on sem.StudentID equals st.StudentID
                //            join ssr in entities.StudentSubjectRegistrations on st.CollegeID equals ssr.ExamCenterCollegeID
                //            where sem.ExamNotificationID == eNID && ssr.ExamCenterCollegeID == colID && sem.SubjectID == subID
                //            && sem.ExternalMarks == absentMarks
                //            select sem;
                foreach (var item in studentsIDs)
                {
                    entities.StudentExternalMarks.Remove(item);
                }


                for (int i = 0; i < rlbRightListStudents.Items.Count; i++)
                {
                    int stID = Convert.ToInt32(rlbRightListStudents.Items[i].Value);

                    StudentExternalMark semEntity = entities.StudentExternalMarks.Where(sem => sem.StudentID == stID && sem.ExamNotificationID == eNID && sem.SubjectID == subID).Select(s => s).FirstOrDefault();

                    if (semEntity != null)
                    {
                        //if (semEntity.ExternalMarks == -2)
                        //    continue;
                        //else
                        if (semEntity.ExternalMarks == -2)
                        {
                            lblMessage.Text = "'" + semEntity.Student.HallTicketNumber + "' Student Data Already Exists for the above Subject as MP. Please remove Student and Save.";
                            return;
                        }
                        else if (semEntity.ExternalMarks >= 0)
                        {
                            lblMessage.Text = "'" + semEntity.Student.HallTicketNumber + "' Student Data Already Exists for the above Subject with Marks: " + semEntity.ExternalMarks + ". Please remove Student and Save.";
                            return;
                        }
                    }

                    //entities.SaveChanges();

                    entities.StudentExternalMarks.Add(
                   new StudentExternalMark
                   {
                       StudentID = stID,
                       ExamNotificationID = eNID,
                       ExternalMarks = absentMarks,
                       SubjectID = subID
                   });
                }
                entities.SaveChanges();

                tdStudents.Visible = false;
            }

            rcbExaminationSubjects.ClearSelection();
            rcbExaminationSubjects.Items.Clear();
            rcbBranches.ClearSelection();
            rbUpload.Enabled = false;
        }
    }
}