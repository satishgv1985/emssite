

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JEMS.admin
{
    public partial class ManageExamNotification : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            rdtpLateFee1StartDate.SelectedDate = rdtpLateFee2StartDate.SelectedDate = DateTime.UtcNow;
            rdtpNotificationStartDate.SelectedDate = DateTime.Now.AddDays(2);
            rdtpNotificationEndDate.SelectedDate = DateTime.Now.AddDays(10);
        }
        protected void rbSave_Click(object sender, EventArgs e)
        {
            JNTUAEMSEntities entities = new JNTUAEMSEntities();

            ExamNotification en = new ExamNotification();
            en.CourseID = Convert.ToByte(rcbCourses.SelectedValue);
            en.SemesterID = Convert.ToInt16(rcbSemester.SelectedValue);
            en.IsRegular = 0; //1-Regular, 2-Supply,3-both
            foreach (ListItem item in cblRegSupply.Items)
            {
                if (item.Selected && item.Text.ToLower().Contains("reg"))
                    en.IsRegular = 1;
                if (item.Selected && item.Text.ToLower().Contains("sup"))
                    en.IsRegular += 2;
            }
            en.RegulationID = Convert.ToByte(rcbRegulation.SelectedValue);
            en.ExamNotificationYear = Convert.ToInt16(rcbNotificationYear.SelectedValue);
            en.Description = rtbDescriptionForResult.Text;
            en.NotificationStartDate = rdtpNotificationStartDate.SelectedDate;
            en.LateFee1 = Convert.ToDecimal(rntbNotificationLateFee1.Value);
            en.LateFee2 = Convert.ToDecimal(rntbNotificationLateFee2.Value);
            en.LateFee1Date = rdtpLateFee1StartDate.SelectedDate;
            en.LateFee2Date = rdtpLateFee2StartDate.SelectedDate;
            en.NotificationEndDate = rdtpNotificationEndDate.SelectedDate;


            entities.ExamNotifications.AddObject(en);
            entities.SaveChanges();


            //ExamNotificationBatchYear enby = new ExamNotificationBatchYear();
            //foreach (ListItem item in cblBatches.Items)
            //{
            //    if (item.Selected)
            //        enby.BatchYearID = 1;
            //}

            //List<ExamNotificationBatchYear> enbyList = new List<ExamNotificationBatchYear>();

            //enbyList.Add(new ExamNotificationBatchYear{BatchYearID=1,ExamNotificationID=en.ExamNotificationID});

            //cblBatches.Items.Cast<ListItem>().Where(item => item.Selected == true).Select(new ExamNotificationBatchYear
            //            {
            //                BatchYearID = Convert.ToInt16(2),
            //                ExamNotificationID = en.ExamNotificationID
            //            });

            foreach (ListItem item in cblBatches.Items)
            {
                if (item.Selected)
                    entities.ExamNotificationBatchYears.AddObject(
                        new ExamNotificationBatchYear
                        {
                            BatchYearID = Convert.ToInt16(item.Value),
                            ExamNotificationID = en.ExamNotificationID
                        });

            }


            var subs = entities.Subjects.Where(sub => sub.CourseID == en.CourseID && sub.SemesterID == en.SemesterID).Select(sub => sub);

            foreach (var item in subs)
            {
                entities.ExamNotificationSubjects.AddObject(new ExamNotificationSubject
                        {
                            SubjectID = item.SubjectID,
                            ExamNotificationID = en.ExamNotificationID
                        });
            }

            //ent.ExamNotificationSubjects.AddObjects(ent.Subjects.Where(sub => sub.CourseID == en.CourseID && sub.SemesterID == en.SemesterID).Select(sb => new ExamNotificationSubject()
            //{
            //    SubjectID=sb.SubjectID,
            //    ExamNotificationID=en.ExamNotificationID,                
            //}).ToList());
            lblMessage.Visible = true;

            try
            {
                entities.SaveChanges();
            }
            catch (Exception ex)
            {
                lblMessage.Text += "----" + ex.Message + "----";
            }

        }

        protected void rcbExistingNotifications_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            JNTUAEMSEntities entities = new JNTUAEMSEntities();

            ExamNotification en = entities.ExamNotifications.ToList().SingleOrDefault(n => n.ExamNotificationID == Convert.ToInt16(rcbExistingNotifications.SelectedValue));

            rcbCourses.SelectedValue = en.CourseID + "";
            rcbSemester.SelectedValue = en.SemesterID + "";
            rcbCourses.Enabled = rcbSemester.Enabled = false;

            foreach (ListItem item in cblRegSupply.Items)
            {
                if (en.IsRegular == 3)
                {
                    item.Selected = true;
                    continue;
                }
                if (en.IsRegular == 1 && item.Text.ToLower().Contains("reg"))
                    item.Selected = true;
                if (en.IsRegular == 2 && item.Text.ToLower().Contains("sup"))
                    item.Selected = true;
            }


            rcbRegulation.SelectedValue = en.RegulationID + "";

            rcbNotificationYear.SelectedValue = en.ExamNotificationYear + "";

            rtbDescriptionForResult.Text = en.Description;

            rdtpNotificationStartDate.SelectedDate = en.NotificationStartDate;
            rntbNotificationLateFee1.Value = Convert.ToDouble(en.LateFee1);
            rntbNotificationLateFee2.Value = Convert.ToDouble(en.LateFee2);
            rdtpLateFee1StartDate.SelectedDate = en.LateFee1Date;
            rdtpLateFee2StartDate.SelectedDate = en.LateFee2Date;
            rdtpNotificationEndDate.SelectedDate = en.NotificationEndDate;

            var enbyForNotification = entities.ExamNotificationBatchYears.ToList().Where(by => by.ExamNotificationID == Convert.ToInt16(rcbExistingNotifications.SelectedValue));
            //var enbyForNotification=entities.ExamNotificationBatchYears.SelectMany(n => n.ExamNotificationID == Convert.ToInt16(rcbExistingNotifications.SelectedValue));
            foreach (var enby in enbyForNotification)
            {
                cblBatches.Items.FindByValue(enby.ExamNotificationBatchYearID + "").Selected = true;

            }
        }
    }
}