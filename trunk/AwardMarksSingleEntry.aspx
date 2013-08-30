<%@ Page Title="" Language="C#" MasterPageFile="~/JntuSite.Master" AutoEventWireup="true"
    CodeBehind="ManageExamNotification.aspx.cs" Inherits="JEMS.admin.ManageExamNotification" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table border="0" cellpadding="10" cellspacing="0" width="100%">
        <tr>
            <td colspan="2">
                <telerik:RadButton ID="rbHeading" runat="server" Style="top: 0px; left: 0px; height: 21px;"
                    Text="Manage Exam Notification">
                </telerik:RadButton>
            </td>
        </tr>
        <tr id="trMessage" runat="server">
            <td colspan="2" class="statusMessage">
                <asp:Label ID="lblMessage" runat="server" Text="Data Saved Successfully." Visible="false"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Select Existing Notification:
            </td>
            <td>
                <telerik:RadComboBox ID="rcbExistingNotifications" runat="server" DataSourceID="sdsExistingNotifications"
                    DataTextField="Description" DataValueField="ExamNotificationID" AutoPostBack="true"
                    EmptyMessage="--Select Notification--" OnSelectedIndexChanged="rcbExistingNotifications_SelectedIndexChanged">
                </telerik:RadComboBox>
                <asp:SqlDataSource ID="sdsExistingNotifications" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                    SelectCommand="SELECT ExamNotificationID,ExamNotificationCode, Description FROM ExamNotification">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="font-weight: bold; font-style: italic">
                Or Create New one from Below
            </td>
        </tr>
        <tr>
            <td>
                Select Course:
            </td>
            <td>
                <telerik:RadComboBox ID="rcbCourses" runat="server" DataSourceID="sdsCourses" DataTextField="CourseName"
                    DataValueField="CourseID" AutoPostBack="true" EmptyMessage="--Select Course--">
                </telerik:RadComboBox>
                 <asp:RequiredFieldValidator ID="rfvCourses" runat="server" ControlToValidate="rcbCourses" SetFocusOnError="true"
                    ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:SqlDataSource ID="sdsCourses" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                    SelectCommand="SELECT CourseID, CourseName, CourseCode FROM Course"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                Select Semester:
            </td>
            <td>
                <telerik:RadComboBox ID="rcbSemester" runat="server" DataSourceID="sdsSemester" DataTextField="SemesterName"
                    DataValueField="SemesterID">
                </telerik:RadComboBox>
                <asp:SqlDataSource ID="sdsSemester" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                    SelectCommand="SELECT SemesterID, SemesterName FROM Semester where CourseID=@courseID">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="rcbCourses" Name="CourseID" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                Reg/Supply:
            </td>
            <td>
                <asp:CheckBoxList ID="cblRegSupply" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Text="Regular" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Supplymentary" Value="2"></asp:ListItem>
                </asp:CheckBoxList>
            </td>
        </tr>
        <tr>
            <td>
                Regulation:
            </td>
            <td>
                <telerik:RadComboBox ID="rcbRegulation" runat="server" DataSourceID="EntityDataSource1"
                    DataTextField="RegulationName" DataValueField="RegulationID">
                </telerik:RadComboBox>
                <asp:EntityDataSource ID="EntityDataSource1" runat="server" ConnectionString="name=JNTUAEMSEntities"
                    DefaultContainerName="JNTUAEMSEntities" EnableFlattening="False" EntitySetName="Regulations"
                    Select="it.[RegulationID], it.[RegulationName], it.[RegulationCode]">
                </asp:EntityDataSource>
                <asp:SqlDataSource ID="sdsRegulation" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                    SelectCommand="SELECT RegulationID, RegulationName, RegulationCode FROM Regulation">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                Notification Month:
            </td>
            <td>
                <telerik:RadTextBox ID="rtbNotificationMonth" runat="server">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td>
                Notification Year:
            </td>
            <td>
                <telerik:RadComboBox ID="rcbNotificationYear" runat="server">
                    <Items>
                        <telerik:RadComboBoxItem Text="2013" Value="2013" Selected="true" />
                        <telerik:RadComboBoxItem Text="2014" Value="2014" />
                        <telerik:RadComboBoxItem Text="2015" Value="2015" />
                        <telerik:RadComboBoxItem Text="2016" Value="2016" />
                    </Items>
                </telerik:RadComboBox>
            </td>
        </tr>
        <tr>
            <td>
                Description To Display in TSheet:
            </td>
            <td>
                <telerik:RadTextBox ID="rtbDescriptionForResult" runat="server" TextMode="MultiLine"
                    ShouldResetWidthInPixels="true" Width="300px">
                </telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="rtbDescriptionForResult"
                    ErrorMessage="*" ForeColor="Red"  SetFocusOnError="true"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                For Batches:
            </td>
            <td>
                <asp:CheckBoxList ID="cblBatches" runat="server" RepeatDirection="Horizontal" RepeatColumns="4"
                    DataSourceID="sdsBatchYears" DataTextField="BatchYear" DataValueField="BatchYearID">
                </asp:CheckBoxList>
                <asp:SqlDataSource ID="sdsBatchYears" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                    SelectCommand="SELECT BatchYearID, BatchYear FROM BatchYear"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                Notification Start Date:
            </td>
            <td>
                <telerik:RadDateTimePicker ID="rdtpNotificationStartDate" runat="server">
                </telerik:RadDateTimePicker>
            </td>
        </tr>
        <%-- <tr>
            <td>Fee:
            </td>
            <td>
                <telerik:RadNumericTextBox ID="rntbNotificationFee" runat="server"></telerik:RadNumericTextBox>
            </td>
        </tr>--%>
        <tr>
            <td>
                Late Fee1 Start Date:
            </td>
            <td>
                <telerik:RadDateTimePicker ID="rdtpLateFee1StartDate" runat="server">
                </telerik:RadDateTimePicker>
            </td>
        </tr>
        <tr>
            <td>
                Late Fee1:
            </td>
            <td>
                <telerik:RadNumericTextBox ID="rntbNotificationLateFee1" runat="server">
                </telerik:RadNumericTextBox>
            </td>
        </tr>
        <tr>
            <td>
                Late Fee2 Start Date:
            </td>
            <td>
                <telerik:RadDateTimePicker ID="rdtpLateFee2StartDate" runat="server">
                </telerik:RadDateTimePicker>
            </td>
        </tr>
        <tr>
            <td>
                Late Fee2:
            </td>
            <td>
                <telerik:RadNumericTextBox ID="rntbNotificationLateFee2" runat="server">
                </telerik:RadNumericTextBox>
            </td>
        </tr>
        <tr>
            <td>
                Notification End Date:
            </td>
            <td>
                <telerik:RadDateTimePicker ID="rdtpNotificationEndDate" runat="server">
                </telerik:RadDateTimePicker>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <telerik:RadButton ID="rbSave" runat="server" Text="Save" OnClick="rbSave_Click">
                </telerik:RadButton>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="sdsExamNotificaiton" runat="server">
        <InsertParameters>
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>
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