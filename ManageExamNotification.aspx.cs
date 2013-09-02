﻿using JntuApp.EntityModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JntuApp.admin
{
    public partial class ManageExamNotification : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rdtpLateFee1StartDate.SelectedDate = rdtpLateFee2StartDate.SelectedDate = DateTime.UtcNow;
                rdtpNotificationStartDate.SelectedDate = DateTime.Now.AddDays(2);
                rdtpNotificationEndDate.SelectedDate = DateTime.Now.AddDays(10);

                PopulateExistingNotifications();
            }
        }
        protected void rbSave_Click(object sender, EventArgs e)
        {
            JNTUAEMSEntities entities = new JNTUAEMSEntities();
            ExamNotification en;
            if (rcbExistingNotifications.SelectedIndex > -1)
            {
                en = entities.ExamNotifications.ToList().SingleOrDefault(ex => ex.ExamNotificationID == Convert.ToInt16(rcbExistingNotifications.SelectedValue));
                en.ExamNotificationID = Convert.ToInt16(rcbExistingNotifications.SelectedValue);               
            }
            else
            {
                en = new ExamNotification();
            }
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
            en.MonthName = rtbNotificationMonth.Text;
            en.NotificationStartDate = rdtpNotificationStartDate.SelectedDate;
            en.LateFee1 = Convert.ToDecimal(rntbNotificationLateFee1.Value);
            en.LateFee2 = Convert.ToDecimal(rntbNotificationLateFee2.Value);
            en.LateFee1Date = rdtpLateFee1StartDate.SelectedDate;
            en.LateFee2Date = rdtpLateFee2StartDate.SelectedDate;
            en.NotificationEndDate = rdtpNotificationEndDate.SelectedDate;

            if (rcbExistingNotifications.SelectedIndex > -1)
            {
                // dont add after save changes it will automatically saves
            }

            else
                entities.ExamNotifications.Add(en);

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

            // For edit we need to delete all for that batch and save again

            ViewState["SelectedNotificationID"] = en.ExamNotificationID;

            if (rcbExistingNotifications.SelectedIndex > -1)
            {
                //Clear the batch years as only new items will be saved
                var batchYears = entities.ExamNotificationBatchYears.Where(by => by.ExamNotificationID == en.ExamNotificationID).Select(by => by);
                foreach (var item in batchYears)
                {
                    entities.ExamNotificationBatchYears.Remove(item);
                }

                rcbCourses.Enabled = false;
                rcbSemester.Enabled = false;
            }
            else
            {
                var subs = entities.Subjects.Where(sub => sub.CourseID == en.CourseID && sub.SemesterID == en.SemesterID).Select(sub => sub);

                foreach (var item in subs)
                {
                    entities.ExamNotificationSubjects.Add(new ExamNotificationSubject
                    {
                        SubjectID = item.SubjectID,
                        ExamNotificationID = en.ExamNotificationID
                    });
                }
            }

            //Insert the selected batch years
            foreach (ListItem item in cblBatches.Items)
            {
                if (item.Selected)
                    entities.ExamNotificationBatchYears.Add(
                        new ExamNotificationBatchYear
                        {
                            BatchYearID = Convert.ToInt16(item.Value),
                            ExamNotificationID = en.ExamNotificationID
                        });
            }

            lblMessage.Visible = true;

            try
            {
                entities.SaveChanges();
            }
            catch (Exception ex)
            {
                lblMessage.Text += "----" + ex.Message + "----";
            }

            PopulateExistingNotifications();
        }

        private void PopulateExistingNotifications()
        {
            rcbExistingNotifications.ClearSelection();
            rcbExistingNotifications.DataSource = sdsExistingNotifications.Select(DataSourceSelectArguments.Empty);
            rcbExistingNotifications.DataBind();
            rcbExistingNotifications.SelectedValue = Convert.ToString(ViewState["SelectedNotificationID"]);
        }

        protected void rcbExistingNotifications_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            //if (rcbExistingNotifications.SelectedIndex > -1)
            //{
            //    //Need to empty all the fields
            //    return;
            //}

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
            rtbNotificationMonth.Text = en.MonthName;
            rdtpNotificationStartDate.SelectedDate = en.NotificationStartDate;
            rntbNotificationLateFee1.Value = Convert.ToDouble(en.LateFee1);
            rntbNotificationLateFee2.Value = Convert.ToDouble(en.LateFee2);
            rdtpLateFee1StartDate.SelectedDate = en.LateFee1Date;
            rdtpLateFee2StartDate.SelectedDate = en.LateFee2Date;
            rdtpNotificationEndDate.SelectedDate = en.NotificationEndDate;

            var enbyForNotification = entities.ExamNotificationBatchYears.ToList().Where(by => by.ExamNotificationID == Convert.ToInt16(rcbExistingNotifications.SelectedValue));
            //var enbyForNotification=entities.ExamNotificationBatchYears.SelectMany(n => n.ExamNotificationID == Convert.ToInt16(rcbExistingNotifications.SelectedValue));

            if (enbyForNotification.Count()>0)
            {
                cblBatches.ClearSelection();
                foreach (var enby in enbyForNotification)
                {
                    cblBatches.Items.FindByValue(enby.BatchYearID + "").Selected = true;
                }
            }
        }
    }
}