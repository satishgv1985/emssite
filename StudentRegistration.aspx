<%@ Page Title="" Language="C#" MasterPageFile="~/CollegeSite.Master" AutoEventWireup="true" CodeBehind="StudentRegistration.aspx.cs" Inherits="JntuCollegeEMS.college.StudentRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Register Student to Notification</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table class="headingTable">
        <tr>
            <td colspan="2">

                <telerik:RadButton ID="rbHeading" runat="server" Style="top: 0px; left: 0px; height: 21px;" AutoPostBack="false"
                    Text="Register Student to Notification">
                </telerik:RadButton>
            </td>
        </tr>
        <tr id="trMessage" runat="server" class="statusMessage">
            <td colspan="2">
                <asp:Label ID="lblMessage" runat="server" Text="Data Saved Successfully." Visible="false"></asp:Label>
            </td>
        </tr>
    </table>
    <table class="notificationTable">
        <tr>
            <td>Select Notification:
            </td>
            <td>
                <telerik:RadComboBox ID="rcbNotification" runat="server" DataSourceID="sdsExamNotification"
                    DataTextField="Description" DataValueField="ExamNotificationID"
                    AutoPostBack="true" EmptyMessage="--Select Notification--"
                    OnSelectedIndexChanged="rcbNotification_SelectedIndexChanged"
                    Width="400">
                </telerik:RadComboBox>
                <asp:SqlDataSource ID="sdsExamNotification" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                    SelectCommand="SELECT ExamNotificationID, Description FROM ExamNotification"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>Course:
            </td>
            <td>
                <telerik:RadComboBox ID="rcbCourses" runat="server" DataSourceID="sdsCourses"
                    DataTextField="CourseName" DataValueField="CourseID" Enabled="false"
                    Width="200px">
                </telerik:RadComboBox>
                <asp:SqlDataSource ID="sdsCourses" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                    SelectCommand="SELECT CourseID, CourseName, CourseCode FROM Course where CourseID IN(SELECT CourseID FROM ExamNotification WHERE ExamNotificationID=@ExamNotificationID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="rcbNotification" Name="ExamNotificationID" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>Semester:
            </td>
            <td>
                <telerik:RadComboBox ID="rcbSemester" runat="server" DataSourceID="sdsSemester"
                    DataTextField="SemesterName" DataValueField="SemesterID" Enabled="false"
                    Width="200px">
                </telerik:RadComboBox>
                <asp:SqlDataSource ID="sdsSemester" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                    SelectCommand="SELECT SemesterID, SemesterName FROM Semester where SemesterID IN(SELECT SemesterID FROM ExamNotification WHERE ExamNotificationID=@ExamNotificationID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="rcbNotification" Name="ExamNotificationID" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
    <table border="0" class="statusMessage">
        <tr>
            <td style="text-align: center; font-size: 20px;">
                <asp:Label ID="lblStudentMessage" runat="server" Visible="false" ForeColor="Green" Font-Bold="true"></asp:Label>
            </td>
        </tr>
    </table>
    <table class="innerTable">
        <tr>
            <td>
                <asp:Label ID="lblHallTicketNumber" Text="Enter Hall Ticket Number:" runat="server"></asp:Label>
            </td>
            <td style="text-align: left;">
                <telerik:RadTextBox ID="rtbHallTicketnumber" runat="server" ValidationGroup="StudentDetails" MaxLength="10">
                </telerik:RadTextBox>&nbsp;*
                        <asp:RequiredFieldValidator ID="rfvHallTicketNumber" runat="server" ControlToValidate="rtbHallTicketnumber"
                            ErrorMessage="* Enter Hall Ticket Number" SetFocusOnError="true"
                            ValidationGroup="StudentDetails" ForeColor="Red" Font-Bold="True" Display="Dynamic"></asp:RequiredFieldValidator>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <telerik:RadButton ID="rbGetDetails" runat="server" Text="Get Details" OnClick="rbGetDetails_Click" ValidationGroup="StudentDetails" Enabled="false"></telerik:RadButton>

            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblName" Text="Name:" runat="server"></asp:Label>
            </td>
            <td>

                <telerik:RadTextBox ID="rtbStudentNameValue" runat="server" Enabled="false"
                    Width="250px">
                </telerik:RadTextBox>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Photo
                
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblBranch" Text="Branch" runat="server"></asp:Label>
            </td>
            <td>
                <telerik:RadTextBox ID="rtbBranch" runat="server" Enabled="false" Width="250px">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblRegSupply" Text="Regular or Supply" runat="server"></asp:Label>
            </td>
            <td>
                <asp:RadioButtonList ID="rblRegOrSupply" runat="server">
                    <asp:ListItem Text="Regular" Value="0" Selected="True">
                    </asp:ListItem>
                    <asp:ListItem Text="Supplementary" Value="1"></asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <%--  <tr>
            <td>
                <asp:Label ID="lblYear" Text="Year" runat="server"></asp:Label>
            </td>
            <td>
                <telerik:RadMonthYearPicker ID="rmypMonthYear" runat="server" ZIndex="30001">
                </telerik:RadMonthYearPicker>
                 <telerik:RadComboBox ID="trcYear" runat="server">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Text="2012" Value="2012" Selected="True" />
                                <telerik:RadComboBoxItem runat="server" Text="2013" Value="2013" />
                            </Items>
                        </telerik:RadComboBox>
            </td>
        </tr>--%>

        <tr>
            <td colspan="2">
                <asp:Label ID="lblSubjects" Text="Select Subjects" runat="server" Font-Bold="true"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <telerik:RadGrid ID="rgStudentSubjects" runat="server" AutoGenerateColumns="false" AllowMultiRowEdit="true" OnPreRender="rgStudentSubjects_PreRender">
                    <MasterTableView>
                        <Columns>
                            <telerik:GridTemplateColumn UniqueName="CheckTemp" HeaderText="CheckTemp">
                                <HeaderTemplate>
                                    Select
                                   <%-- <asp:CheckBox ID="CheckBox2" AutoPostBack="true" runat="server" OnCheckedChanged="CheckBox2_CheckedChanged1" />--%>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="CheckBox3" runat="server" Checked="true" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="SubjectID" FilterControlAltText="Filter SubjectID column"
                                HeaderText="SubjectID" ReadOnly="True" SortExpression="SubjectID" UniqueName="SubjectID"
                                Visible="false">
                            </telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="SubjectCode" FilterControlAltText="Filter SubjectCode column"
                                HeaderText="SubjectCode" SortExpression="SubjectCode" UniqueName="SubjectCode" ReadOnly="true">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SubjectName" FilterControlAltText="Filter SubjectName column" ItemStyle-Width="300Px"
                                HeaderText="SubjectName" SortExpression="SubjectName" UniqueName="SubjectName" ReadOnly="true">
                            </telerik:GridBoundColumn>

                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
                <asp:SqlDataSource ID="sdsStudentSubjects" runat="server">
                    <SelectParameters></SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <telerik:RadButton ID="rbRegister" runat="server" Text="Register" OnClick="rbRegister_Click" Enabled="false">
                </telerik:RadButton>
            </td>
        </tr>
    </table>
</asp:Content>
using JntuBusinessLogic.EFModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace JntuCollegeEMS.college
{
    public partial class StudentRegistration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void rbGetDetails_Click(object sender, EventArgs e)
        {
            //lblStudentMessage.Visible = false;

            JNTUAEMSEntities entities = new JNTUAEMSEntities();
            //Student st = new Student();
            //byte cID = Convert.ToByte(rcbCourses.SelectedValue);
            //short semID = Convert.ToInt16(rcbSemester.SelectedValue);
            //short collegeID = Convert.ToInt16(Session["CollegeID"]);


            //st = entities.Students.Where(s => s.CourseID == cID && s.CollegeID == collegeID).SingleOrDefault(s => s.HallTicketNumber == rtbHallTicketnumber.Text);
            //if (st == null)
            //{
            //    lblStudentMessage.Text = rtbHallTicketnumber.Text + " Student Does Not Exist in the College";
            //    lblStudentMessage.Visible = true;
            //    ClearSelections();

            //    return;
            //}
            //ViewState["StudentID"] = st.StudentID;
            //ViewState["HTNO"] = st.HallTicketNumber;
            //rtbStudentNameValue.Text = st.StudentName;
            //rtbBranch.Text = st.Branch.BranchName;

            //var sbs = entities.Subjects.Where(sb => sb.BranchID == st.BranchID && sb.CourseID == st.CourseID && sb.SemesterID == semID).Select(sb => sb);

            //rgStudentSubjects.DataSource = sbs.ToList();
            //rgStudentSubjects.DataBind();

            //rbRegister.Enabled = true;

            #region Code to register an entire college
            string colCode = "T1";
            short exID = 116;
            short colID = entities.Colleges.Where(cl => cl.CollegeCode == colCode).FirstOrDefault().CollegeID;
            var colStudents = entities.Students.Where(s => s.CollegeID == colID).Select(s => s);
            foreach (var item in colStudents)
            {
                var stRegistered = entities.StudentSubjectRegistrations.Where(ssr => ssr.StudentID == item.StudentID).Where(ssr => ssr.ExamNotificationID == exID).Select(ssr => ssr);
                if (stRegistered.Count() > 0)
                {
                    //Already registered for some subjects
                    continue;
                }


                var studentSubjects = entities.Subjects.Where(sb => sb.BranchID == item.BranchID).Where(sb => sb.CourseID == item.CourseID).Select(sb => sb);

                foreach (var ss in studentSubjects)
                {
                    entities.StudentSubjectRegistrations.Add(new StudentSubjectRegistration
                        {
                            ExamNotificationID = exID,
                            StudentID = item.StudentID,
                            SubjectID = ss.SubjectID
                        });
                }

            }
            entities.SaveChanges();
            #endregion

        }

        protected void rbRegister_Click(object sender, EventArgs e)
        {
            JNTUAEMSEntities entities = new JNTUAEMSEntities();

            lblStudentMessage.Visible = true;

            int stID = Convert.ToInt32(ViewState["StudentID"]);
            short enID = Convert.ToInt16(rcbNotification.SelectedValue);

            //entities.StudentSubjectRegistrations.First(
            var stRegistered = entities.StudentSubjectRegistrations.Where(st => st.StudentID == stID).Where(st => st.ExamNotificationID == enID).Select(st => st);
            if (stRegistered.Count() > 0)
            {
                lblStudentMessage.Text = Convert.ToString(ViewState["HTNO"]) + " Student Already Registered For the Selected notification. ";
                rbRegister.Enabled = false;
                ClearSelections();
                return;
            }
            try
            {
                foreach (GridDataItem item in rgStudentSubjects.MasterTableView.Items)
                {
                    CheckBox cb = (CheckBox)item.Cells[2].Controls[1];
                    if (cb.Checked)
                    {
                        entities.StudentSubjectRegistrations.Add(new StudentSubjectRegistration
                        {
                            ExamNotificationID = enID,
                            StudentID = stID,
                            SubjectID = Convert.ToInt32(item.Cells[3].Text),
                            RegOrSupply = rblRegOrSupply.SelectedValue == "0" ? true : false
                        });
                    }
                }
                entities.ExamCenterEnrollments.Add(new ExamCenterEnrollment
                {
                    ExamNotificationID = enID,
                    StudentID = stID
                });
                entities.SaveChanges();

            }
            catch (Exception ex)
            {
                lblStudentMessage.Text = "Error Occured.  " + ex.Message;
                return;
            }
            lblStudentMessage.Text = Convert.ToString(ViewState["HTNO"]) + " Student Registered Successfully.";

            ClearSelections();

        }

        private void ClearSelections()
        {
            rtbHallTicketnumber.Text = rtbStudentNameValue.Text = rtbBranch.Text = "";
            rtbHallTicketnumber.Focus();
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

        protected void rcbNotification_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            rbGetDetails.Enabled = true;
        }
    }

}