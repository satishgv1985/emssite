<%@ Page Title="" Language="C#" MasterPageFile="~/JntuSite.Master" AutoEventWireup="true"
    CodeBehind="StudentRegistration.aspx.cs" Inherits="JEMS.StudentRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Register Student to Notification</title>
    <script type="text/javascript">
        function removeSelections(sender, args) {
            var cbSelected = document.getElementById('cbSelectElectives').checked;
            var controls = document.getElementById("<%=pnlElectives.ClientID%>").getElementsByTagName("input");
            for (var i = 0; i < controls.length; i++)
                controls[i].disabled = !cbSelected;

            if (!cbSelected) {
                var radios = document.getElementsByTagName('input');
                for (var i = 0; i < radios.length; i++) {
                    if (radios[i].type === 'radio') {
                        if (radios[i].value == "0" || radios[i].value == "1") continue; // For Regular and Supply radio buttons
                        radios[i].checked = false;
                    }
                }
            }
        }

        function supplySelected() {
            var cbSelected = document.getElementById('rbSupplementary').checked;
            var grid = $find("<%=rgStudentSubjects.ClientID %>");
            var masterTable = grid.get_masterTableView();
            if (masterTable == null) return;
            for (var i = 0; i < masterTable.get_dataItems().length; i++) {
                var gridItemElement = masterTable.get_dataItems()[i].findElement("cbGridCheckBox");
                gridItemElement.checked = !cbSelected;
            }
        }

        function GetElectivesSelected(sender, args) {
            alert('hi');
        }
        function selElective(eleNo, subID) {
            if (eleNo == 1)
                document.getElementById("<%=hdnElective1.ClientID%>").value = subID;
            else if (eleNo == 2)
                document.getElementById("<%=hdnElective2.ClientID%>").value = subID;
            else if (eleNo == 3)
                document.getElementById("<%=hdnElective3.ClientID%>").value = subID;
            else if (eleNo == 4)
                document.getElementById("<%=hdnElective4.ClientID%>").value = subID;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="headingTable">
        <tr>
            <td colspan="2">
                <telerik:RadButton ID="rbHeading" runat="server" Style="top: 0px; left: 0px; height: 21px;"
                    AutoPostBack="false" Text="Register Student to Notification">
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
            <td>
                Select Notification:
            </td>
            <td>
                <telerik:RadComboBox ID="rcbNotification" runat="server" DataSourceID="odsExamNotifications"
                    DataTextField="Description" DataValueField="ExamNotificationID" AutoPostBack="True"
                    EmptyMessage="--Select Notification--" OnSelectedIndexChanged="rcbNotification_SelectedIndexChanged"
                    Width="400px">
                </telerik:RadComboBox>
                <asp:ObjectDataSource ID="odsExamNotifications" runat="server" SelectMethod="GetNotificationsByCollegeID"
                    TypeName="JEMS.DTO_Notification">
                    <SelectParameters>
                        <asp:SessionParameter Name="collegeID" SessionField="CollegeID" Type="Int32" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <%--<asp:SqlDataSource ID="sdsExamNotification" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                    SelectCommand="SELECT ExamNotificationID, Description FROM ExamNotification">
                </asp:SqlDataSource>--%>
            </td>
        </tr>
        <tr>
            <td>
                Course:
            </td>
            <td>
                <telerik:RadComboBox ID="rcbCourses" runat="server" DataSourceID="sdsCourses" DataTextField="CourseName"
                    DataValueField="CourseID" Enabled="false" Width="200px">
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
            <td>
                Semester:
            </td>
            <td>
                <telerik:RadComboBox ID="rcbSemester" runat="server" DataSourceID="sdsSemester" DataTextField="SemesterName"
                    DataValueField="SemesterID" Enabled="false" Width="200px">
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
                <asp:Label ID="lblStudentMessage" runat="server" Visible="false" ForeColor="Green"
                    Font-Bold="true"></asp:Label>
            </td>
        </tr>
    </table>
    <table class="innerTable">
        <tr>
            <td>
                <table class="innerTable">
                    <tr>
                        <td>
                            <asp:Label ID="lblHallTicketNumber" Text="Enter Hall Ticket Number:" runat="server"></asp:Label>
                        </td>
                        <td style="text-align: left;">
                            <%-- <asp:TextBox ID="tbHallTicketNumber" runat="server" ValidationGroup="StudentDetails" MaxLength="10"></asp:TextBox>--%>
                            <telerik:RadTextBox ID="rtbHallTicketnumber" runat="server" ValidationGroup="StudentDetails"
                                MaxLength="10">
                            </telerik:RadTextBox>&nbsp;*
                            <asp:RequiredFieldValidator ID="rfvHallTicketNumber" runat="server" ControlToValidate="rtbHallTicketNumber"
                                ErrorMessage="* Enter Hall Ticket Number" SetFocusOnError="true" ValidationGroup="StudentDetails"
                                ForeColor="Red" Font-Bold="True" Display="Dynamic"></asp:RequiredFieldValidator>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <telerik:RadButton ID="rbGetDetails" runat="server" Text="Get Details" OnClick="rbGetDetails_Click"
                                ValidationGroup="StudentDetails" Enabled="false">
                            </telerik:RadButton>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblName" Text="Name:" runat="server"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="rtbStudentNameValue" runat="server" Enabled="false" Width="250px">
                            </telerik:RadTextBox>
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
                        <td runat="server" visible="false" id="tdRegularOrSupply">
                            <span style="padding: 10px; border: 1px solid black; display: inline-block;">
                                <asp:RadioButton ID="rbRegular" runat="server" GroupName="RegSupply" Text="Regular"
                                    onclick="supplySelected()" />
                                <br />
                                <asp:RadioButton ID="rbSupplementary" runat="server" GroupName="RegSupply" Text="Supplementary"
                                    ClientIDMode="Static" onclick="supplySelected()" />
                                <%--
                                <telerik:RadButton ID="rbRegular" runat="server" ToggleType="Radio" ButtonType="ToggleButton"
                                    Text="Regular" GroupName="StandardButton" AutoPostBack="false">
                                </telerik:RadButton>--%>
                                <%--
                                <telerik:RadButton ID="rbSupplementary" runat="server" ToggleType="Radio" Text="Supplementary"
                                    GroupName="StandardButton" ButtonType="ToggleButton" AutoPostBack="false" OnClientCheckedChanged="supplySelected">
                                </telerik:RadButton>--%>
                            </span>
                        </td>
                    </tr>
                </table>
            </td>
            <td>
                <asp:Image ID="imgStudentImage" runat="server" Height="100px" Width="100px" />
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
                <telerik:RadGrid ID="rgStudentSubjects" runat="server" AutoGenerateColumns="false"
                    AllowMultiRowEdit="true" OnPreRender="rgStudentSubjects_PreRender">
                    <MasterTableView>
                        <Columns>
                            <telerik:GridTemplateColumn UniqueName="CheckTemp" HeaderText="CheckTemp">
                                <HeaderTemplate>
                                    Select
                                    <%-- <asp:CheckBox ID="CheckBox2" AutoPostBack="true" runat="server" OnCheckedChanged="CheckBox2_CheckedChanged1" />--%>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="cbGridCheckBox" runat="server" />
                                    <%-- <telerik:RadButton ID="rbGridCheckBox" runat="server" ToggleType="CheckBox" ButtonType="ToggleButton"
                                        Text="" AutoPostBack="false" CssClass="cssInsideGrid" OnClientLoad="cbLoad">
                                    </telerik:RadButton>--%>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="SubjectID" FilterControlAltText="Filter SubjectID column"
                                HeaderText="SubjectID" ReadOnly="True" SortExpression="SubjectID" UniqueName="SubjectID"
                                Visible="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SubjectCode" FilterControlAltText="Filter SubjectCode column"
                                HeaderText="SubjectCode" SortExpression="SubjectCode" UniqueName="SubjectCode"
                                ReadOnly="true">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SubjectName" FilterControlAltText="Filter SubjectName column"
                                ItemStyle-Width="300Px" HeaderText="SubjectName" SortExpression="SubjectName"
                                UniqueName="SubjectName" ReadOnly="true">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
                <asp:SqlDataSource ID="sdsStudentSubjects" runat="server">
                    <SelectParameters>
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
                <table>
                    <tr>
                        <td>
                            <%--<telerik:RadButton ID="rbSelectElectives" runat="server" ToggleType="CheckBox" ButtonType="ToggleButton"
                                Text="Select/Deselect Electives" AutoPostBack="false" ClientIDMode="Static" Visible="false"
                                OnClientCheckedChanged="removeSelections">
                            </telerik:RadButton>--%>
                            <asp:CheckBox ID="cbSelectElectives" runat="server" Visible="false" onclick="removeSelections();"
                                ClientIDMode="Static" Text="Select/Deselect Electives" Checked="true" />
                            <br />
                            <asp:Panel ID="pnlElectives" runat="server">
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <telerik:RadButton ID="rbRegister" runat="server" Text="Register" OnClick="rbRegister_Click"
                    Enabled="false">
                </telerik:RadButton>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hdnElective1" runat="server" Value="-1" />
    <asp:HiddenField ID="hdnElective2" runat="server" Value="-1" />
    <asp:HiddenField ID="hdnElective3" runat="server" Value="-1" />
    <asp:HiddenField ID="hdnElective4" runat="server" Value="-1" />
</asp:Content>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using JEMS.EntityModel;

namespace JEMS
{
    public partial class StudentRegistration : System.Web.UI.Page
    {
        public enum enumRegular { Regular, Supplementary, Regular_and_Supplementary };

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["CollegeID"] = 154;
        }

        protected void rbGetDetails_Click(object sender, EventArgs e)
        {
            lblStudentMessage.Visible = false;

            using (JNTUAEMSEntities entities = new JNTUAEMSEntities())
            {
                Student st = new Student();
                byte cID = Convert.ToByte(rcbCourses.SelectedValue);
                short semID = Convert.ToInt16(rcbSemester.SelectedValue);
                short collegeID = Convert.ToInt16(Session["CollegeID"]);
                short isRegular = Convert.ToInt16(ViewState["IsRegular"]);

                st = entities.Students.Where(s => s.CourseID == cID && s.CollegeID == collegeID).SingleOrDefault(s => s.HallTicketNumber == rtbHallTicketnumber.Text);
                if (st == null)
                {
                    lblStudentMessage.Text = rtbHallTicketnumber.Text + " Student Does Not Exist in the College with the Selected Course";
                    lblStudentMessage.Visible = true;
                    ClearSelections();
                    return;
                }
                ViewState["StudentID"] = st.StudentID;
                ViewState["HTNO"] = st.HallTicketNumber;
                rtbStudentNameValue.Text = st.StudentName;
                rtbBranch.Text = st.Branch.BranchName;

                var sbs = entities.Subjects.Where(sb => sb.BranchID == st.BranchID && sb.CourseID == st.CourseID && sb.SemesterID == semID).Select(sb => sb);

                var electiveSubjectOrders = sbs.GroupBy(sb => sb.SubjectOrder).Where(grp => grp.Count() > 1).Select(grp => grp.Key);
                var nonElectiveSubjectOrders = sbs.Select(s => s.SubjectOrder).Except(electiveSubjectOrders);

                cbSelectElectives.Visible = electiveSubjectOrders.Count() > 0 ? true : false;

                if (electiveSubjectOrders.Count() == 0) //No Elective Subjects
                    rgStudentSubjects.DataSource = sbs.ToList();
                else // Non-Electives are bind to grid               
                    rgStudentSubjects.DataSource = sbs.Where(so => nonElectiveSubjectOrders.Contains(so.SubjectOrder)).Select(so => so).ToList();

                rgStudentSubjects.DataBind();


                #region Bind Electives

                Table tblElectives;
                short electiveNo = 1;
                foreach (var item in electiveSubjectOrders)
                {
                    cbSelectElectives.Visible = true;
                    Label lblElectiveText = new Label();

                    TableCell tcElectiveList = new TableCell();
                    RadioButton rbE;
                    var electiveSubs = sbs.Where(sb => sb.SubjectOrder == item).Select(g => new
                    {
                        SubjectId = g.SubjectID,
                        SubjectName = g.SubjectCode + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + g.SubjectName
                    });
                    foreach (var es in electiveSubs)
                    {
                        rbE = new RadioButton();
                        rbE.Text = es.SubjectName + "<br />";
                        rbE.GroupName = "Elective" + electiveNo;
                        tcElectiveList.Controls.Add(rbE);
                        rbE.Attributes.Add("onclick", "selElective(" + electiveNo + "," + es.SubjectId + ")");
                    }

                    tblElectives = new Table();
                    TableRow trElectiveHeading = new TableRow();
                    TableRow trElectiveList = new TableRow();
                    TableCell tcElectiveHeading = new TableCell();

                    lblElectiveText.Text = "Elective " + electiveNo;
                    lblElectiveText.Font.Bold = true;
                    tcElectiveHeading.Controls.Add(lblElectiveText);
                    //tcElectiveList.Controls.Add(rbl);

                    trElectiveHeading.Cells.Add(tcElectiveHeading);
                    trElectiveList.Cells.Add(tcElectiveList);

                    tblElectives.Rows.Add(trElectiveHeading);
                    tblElectives.Rows.Add(trElectiveList);

                    pnlElectives.Controls.Add(tblElectives);
                    electiveNo++;
                }
                #endregion

                foreach (GridDataItem item in rgStudentSubjects.MasterTableView.Items)
                {
                    CheckBox cb = (CheckBox)item.Cells[2].Controls[1];
                    if (isRegular == (byte)enumRegular.Regular || isRegular == (byte)enumRegular.Regular_and_Supplementary)
                        cb.Checked = cbSelectElectives.Checked = true;
                    else
                        cb.Checked = cbSelectElectives.Checked = false;
                }

                rbRegister.Enabled = true;

            }

        }

        protected void rbRegister_Click(object sender, EventArgs e)
        {
            JNTUAEMSEntities entities = new JNTUAEMSEntities();

            lblStudentMessage.Visible = true;

            int stID = Convert.ToInt32(ViewState["StudentID"]);
            short enID = Convert.ToInt16(rcbNotification.SelectedValue);

            var stRegistered = entities.StudentSubjectRegistrations.Where(st => st.StudentID == stID).Where(st => st.ExamNotificationID == enID).Select(st => st);
            if (stRegistered.Count() > 0)
            {
                lblStudentMessage.Text = Convert.ToString(ViewState["HTNO"]) + " Student Already Registered For the Selected notification. ";
                rbRegister.Enabled = false;
                ClearSelections();
                return;
            }

            bool isRegular = false;
            if (rbRegular.Checked) isRegular = true;

            try
            {

                foreach (GridDataItem item in rgStudentSubjects.MasterTableView.Items)
                {
                    RadButton cb = (RadButton)item.Cells[2].Controls[1];


                    if (cb.Checked)
                    {
                        //entities.StudentSubjectRegistrations.Add(new StudentSubjectRegistration
                        //{
                        //    ExamNotificationID = enID,
                        //    StudentID = stID,
                        //    SubjectID = Convert.ToInt32(item.Cells[3].Text),
                        //    RegOrSupply = isRegular
                        //});
                    }
                }



                #region SaveElectives
                if (cbSelectElectives.Checked && cbSelectElectives.Visible)
                {
                    HiddenField[] hiddenFields = { hdnElective1, hdnElective2, hdnElective3, hdnElective4 };
                    foreach (var item in hiddenFields)
                    {
                        //if (item.Value != "-1")
                        //    entities.StudentSubjectRegistrations.Add(new StudentSubjectRegistration
                        //   {
                        //       ExamNotificationID = enID,
                        //       StudentID = stID,
                        //       SubjectID = Convert.ToInt32(hdnElective1.Value),
                        //       RegOrSupply = isRegular
                        //   });
                    }
                }
                #endregion


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
            cbSelectElectives.Visible = false;
        }

        protected void rgStudentSubjects_PreRender(object sender, EventArgs e)
        {
            //foreach (GridDataItem data in rgStudentSubjects.MasterTableView.Items)
            //{
            //    data.Edit = true;
            //}
            //rgStudentSubjects.Rebind(); 
        }
        //protected void CheckBox2_CheckedChanged1(object sender, EventArgs e)
        //{
        //    foreach (GridDataItem item in rgStudentSubjects.MasterTableView.Items)
        //    {
        //        CheckBox chkbx = (CheckBox)item["CheckTemp"].FindControl("CheckBox3");
        //        chkbx.Checked = !chkbx.Checked;
        //    }
        //}

        protected void rcbNotification_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            ClearSelections();
            rbGetDetails.Enabled = true;
            short enID = Convert.ToInt16(rcbNotification.SelectedValue);
            using (JNTUAEMSEntities entities = new JNTUAEMSEntities())
            {
                ExamNotification en = entities.ExamNotifications.Where(t => t.ExamNotificationID == enID).First();

                rbRegular.Visible = rbSupplementary.Visible = false;
                rbRegular.Checked = rbSupplementary.Checked = false;
                tdRegularOrSupply.Visible = true;
                ViewState["IsRegular"] = en.IsRegular;

                if (en.IsRegular == (byte)enumRegular.Regular)
                    rbRegular.Visible = rbRegular.Checked = true;
                else if (en.IsRegular == (byte)enumRegular.Supplementary)
                    rbSupplementary.Visible = rbSupplementary.Checked = true;
                else
                {
                    rbRegular.Visible = true;
                    rbSupplementary.Visible = true;
                    rbRegular.Checked = true;
                }
                lblStudentMessage.Visible = false;
            }
        }
    }

} public List<ExamNotification> GetNotificationsByCollegeID(int collegeID)
        {
            using (JNTUAEMSEntities entities = new JNTUAEMSEntities())
            {
                var collegeCourses= entities.CollegeCourseBranches.Where(ccb=>ccb.CollegeID==collegeID).Select(ccb=>ccb.CourseID);
                return entities.ExamNotifications.Where(en => collegeCourses.Contains(en.CourseID)).Select(en => en).ToList();
            }
        }