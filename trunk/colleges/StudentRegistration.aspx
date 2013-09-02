<%@ Page Title="" Language="C#" MasterPageFile="~/JntuSite.Master" AutoEventWireup="true" CodeBehind="StudentRegistration.aspx.cs" Inherits="JntuApp.colleges.StudentRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table border="0" cellpadding="10" cellspacing="0" width="100%">
        <tr>
            <td colspan="2">
                <telerik:RadButton ID="rbHeading" runat="server" Style="top: 0px; left: 0px; height: 21px;"
                    Text="Manage Examination Time Table">
                </telerik:RadButton>
            </td>
        </tr>
        <tr id="trMessage" runat="server">
            <td colspan="2" class="statusMessage">
                <asp:Label ID="lblMessage" runat="server" Text="Data Saved Successfully." Visible="false"></asp:Label>
            </td>
        </tr>
    </table>
    <table border="0" cellpadding="10" cellspacing="0" width="80%" style="border: 1px solid black;">

        <tr>
            <td>Select Notification:
            </td>
            <td>
                <telerik:RadComboBox ID="rcbNotification" runat="server" DataSourceID="sdsExamNotification"
                    DataTextField="Description" DataValueField="ExamNotificationID" AutoPostBack="true" EmptyMessage="--Select Notification--">
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
                    DataTextField="CourseName" DataValueField="CourseID" Enabled="false">
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
                    DataTextField="SemesterName" DataValueField="SemesterID" Enabled="false">
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
    <table border="0" cellpadding="10" cellspacing="0">
        <tr>
            <td colspan="2" style="text-align:center; font-size:20px;">
                <asp:Label ID="lblStudentMessage" runat="server" Visible="false" ForeColor="Green" Font-Bold="true"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblHallTicketNumber" Text="Enter Hall Ticket Number:" runat="server"></asp:Label>
            </td>
            <td style="text-align:left;">
                <telerik:RadTextBox ID="rtbHallTicketnumber" runat="server" ValidationGroup="StudentDetails">
                </telerik:RadTextBox>&nbsp;*
                        <asp:RequiredFieldValidator ID="rfvHallTicketNumber" runat="server" ControlToValidate="rtbHallTicketnumber"
                            ErrorMessage="* Enter Hall Ticket Number" SetFocusOnError="true" ValidationGroup="StudentDetails"></asp:RequiredFieldValidator>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <telerik:RadButton ID="rbGetDetails" runat="server" Text="Get Details" OnClick="rbGetDetails_Click" ValidationGroup="StudentDetails"></telerik:RadButton>

            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblName" Text="Name:" runat="server"></asp:Label>
            </td>
            <td>

                <telerik:RadTextBox ID="rtbStudentNameValue" runat="server" Enabled="false">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblBranch" Text="Branch" runat="server"></asp:Label>
            </td>
            <td>
                <telerik:RadTextBox ID="rtbBranch" runat="server" Enabled="false">
                </telerik:RadTextBox>
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
                <telerik:RadButton ID="rbRegister" runat="server" Text="Register" OnClick="rbRegister_Click">
                </telerik:RadButton>
            </td>
        </tr>
    </table>
</asp:Content>
