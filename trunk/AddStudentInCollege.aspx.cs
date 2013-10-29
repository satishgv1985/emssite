using JntuBusinessLogic.EFModel;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace JntuCollegeEMS.college
{
    public partial class AddStudentInCollege : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void AsyncUpload1_FileUploaded(object sender, FileUploadedEventArgs e)
        {
            //System.Diagnostics.Debugger.Launch();
            Thumbnail.Width = Unit.Pixel(200);
            Thumbnail.Height = Unit.Pixel(150);
            using (Stream stream = e.File.InputStream)
            {
                byte[] imageData = new byte[stream.Length];
                stream.Read(imageData, 0, (int)stream.Length);
                Thumbnail.DataValue = imageData;
            }
        }
        protected void rbSave_Click(object sender, EventArgs e)
        {

            //bool b = ValidateHallTicket(trtHallTicketnumber.Text);

            
            using (JNTUAEMSEntities entities = new JNTUAEMSEntities())
            {
                Student st = new Student();
                st.HallTicketNumber = trtHallTicketnumber.Text;
                st.StudentName = trtStudentName.Text;
                st.FatherName = trtFatherName.Text;
                st.MotherName = trtMotherName.Text;
                st.Gender = Convert.ToBoolean(trcGender.SelectedValue);
                st.RegulationID = Convert.ToByte(rcbRegulation.SelectedValue);
                st.CourseID = HelperClass.GetCourseIDFromHallTicketNo(trtHallTicketnumber.Text);
                st.BranchID = HelperClass.GetBranchIDFromHallTicketNo(trtHallTicketnumber.Text);
                st.CollegeID = Convert.ToInt16(Session["CollegeID"]);

                entities.Students.Add(st);

                entities.SaveChanges();
            }
        }

        //private bool ValidateHallTicket(string htNo)
        //{
        //    string courseCode=htNo[6].ToString();
        //    string branchCode=
        //    //using (JNTUAEMSEntities entities = new JNTUAEMSEntities())
        //    //{
        //    //    //Is Course Valid
        //    //    if (!entities.Courses.Where(cr => cr.CourseCode == courseCode).Any())
        //    //        ShowErrorMessage("Course Code In the HallTicket Is Wrong. Please Check Again");
        //    //    else if(!entities.Branches.Where(br=>br.BranchCode==)
        //    //}
        //}

       

        private void ShowErrorMessage(string p)
        {
            trMessage.Visible = trMessagebelow.Visible = true;
            lblMessage.Text = lblBelowMessage.Text = "Hall Ticket Number Already Registered";
        }
    }
}