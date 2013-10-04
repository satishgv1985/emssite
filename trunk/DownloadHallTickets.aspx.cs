using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JntuCollegeEMS
{
    public partial class GenerateHallTickets : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //DTO.CollegeDTO college = (DTO.CollegeDTO)Session["college"];
                //hfCollegeName.Value = college.UserName;
                //hfCollegeID.Value = Convert.ToString(college.CollegeID);
            }
        }

        protected void rbDownload_Click(object sender, EventArgs e)
        {
            string filePath = Server.MapPath("~/App_Data/" + @"JntuData\halltickets\t1");
            string fileName = "ht.pdf";
            FileStream fileStream;
            if (true)
            {

                fileStream = File.Open(filePath, FileMode.Open);

                byte[] bytBytes = new byte[fileStream.Length];

                int a = fileStream.Read(bytBytes, 0, Convert.ToInt32(fileStream.Length));

                fileStream.Close();

                Response.AddHeader("content-disposition", "attachment; filename=" + fileName);
                Response.ContentType = "application/octet-stream";

                Response.BinaryWrite(bytBytes);

                Response.End();
            }
        }

        protected void rcbNotification_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            rbDownload.Enabled = true;
        }
    }
}