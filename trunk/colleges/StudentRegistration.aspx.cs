using JntuApp.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace JntuApp.colleges
{
    public partial class StudentRegistration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void rbGetDetails_Click(object sender, EventArgs e)
        {
            JNTUAEMSEntities entities = new JNTUAEMSEntities();
            Student st = new Student();

            st = entities.Students.SingleOrDefault(s => s.HallTicketNumber == rtbHallTicketnumber.Text);
            if (st == null)
            {
                lblStudentMessage.Text = "Student Does Not Exist";
                lblStudentMessage.Visible = true;
                return;
            }
            ViewState["StudentID"] = st.StudentID;
            rtbStudentNameValue.Text = st.StudentName;
            rtbBranch.Text = st.Branch.BranchName;

            var sbs = entities.Subjects.Where(sb => sb.BranchID == st.BranchID).Where(sb => sb.CourseID == st.CourseID).Select(sb => sb);

            rgStudentSubjects.DataSource = sbs.ToList();
            rgStudentSubjects.DataBind();

        }

        protected void rbRegister_Click(object sender, EventArgs e)
        {
            JNTUAEMSEntities entities = new JNTUAEMSEntities();
            try
            {
                lblStudentMessage.Visible = true;
                foreach (GridDataItem item in rgStudentSubjects.MasterTableView.Items)
                {
                    CheckBox cb = (CheckBox)item.Cells[2].Controls[1];
                    if (cb.Checked)
                    {
                        entities.StudentSubjectRegistrations.Add(new StudentSubjectRegistration
                        {
                            ExamNotificationID = Convert.ToInt16(rcbNotification.SelectedValue),
                            StudentID = Convert.ToInt32(ViewState["StudentID"]),
                            SubjectID = Convert.ToInt32(item.Cells[3].Text)
                        });
                    }
                }
                entities.SaveChanges();

            }
            catch (Exception ex)
            {
                lblStudentMessage.Text = "Error Occured.  " + ex.Message;
                return;
            }
            lblStudentMessage.Text = "Registered Successfully.";
            rtbHallTicketnumber.Text = rtbStudentNameValue.Text = rtbBranch.Text = "";
            
            rgStudentSubjects.DataSource = null;
            rgStudentSubjects.DataBind();

        }

        protected void rgStudentSubjects_PreRender(object sender, EventArgs e)
        {
            //foreach (GridDataItem data in rgStudentSubjects.MasterTableView.Items)
            //{
            //    data.Edit = true;
            //}
            //rgStudentSubjects.Rebind(); 
        }
        protected void CheckBox2_CheckedChanged1(object sender, EventArgs e)
        {
            foreach (GridDataItem item in rgStudentSubjects.MasterTableView.Items)
            {
                CheckBox chkbx = (CheckBox)item["CheckTemp"].FindControl("CheckBox3");
                chkbx.Checked = !chkbx.Checked;
            }
        }
    }
}