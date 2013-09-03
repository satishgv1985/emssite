<%@ Page Title="" Language="C#" MasterPageFile="~/JntuSite.Master" AutoEventWireup="true" CodeBehind="ManageExamNotification.aspx.cs" Inherits="JntuApp.admin.ManageExamNotification" %>


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
            <td>Select Existing Notification:
            </td>
            <td>
                <telerik:RadComboBox ID="rcbExistingNotifications" runat="server"  Width="400"
                    DataTextField="Description" DataValueField="ExamNotificationID" AutoPostBack="true" EmptyMessage="--Select Notification--"
                    OnSelectedIndexChanged="rcbExistingNotifications_SelectedIndexChanged">
                    
                </telerik:RadComboBox>
                <asp:SqlDataSource ID="sdsExistingNotifications" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                    SelectCommand="SELECT ExamNotificationID,ExamNotificationCode, Description FROM ExamNotification"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="font-weight: bold; font-style: italic">Or Create New one from Below
            </td>
        </tr>
        <tr>
            <td>Select Course:
            </td>
            <td>
                <telerik:RadComboBox ID="rcbCourses" runat="server" DataSourceID="sdsCourses" DataTextField="CourseName"
                    DataValueField="CourseID" AutoPostBack="true" EmptyMessage="--Select Course--">
                </telerik:RadComboBox>
                <%--<asp:RequiredFieldValidator ID="rfvCourses" runat="server" ControlToValidate="rcbCourses" SetFocusOnError="true"
                    ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                <asp:SqlDataSource ID="sdsCourses" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                    SelectCommand="SELECT CourseID, CourseName, CourseCode FROM Course"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>Select Semester:
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
            <td>Reg/Supply:
            </td>
            <td>
                <asp:CheckBoxList ID="cblRegSupply" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Text="Regular" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Supplymentary" Value="2"></asp:ListItem>
                </asp:CheckBoxList>
            </td>
        </tr>
        <tr>
            <td>Regulation:
            </td>
            <td>
                <telerik:RadComboBox ID="rcbRegulation" runat="server" DataSourceID="sdsRegulation"
                    DataTextField="RegulationName" DataValueField="RegulationID"  EmptyMessage="--Select Regulation--">
                </telerik:RadComboBox>
                <asp:SqlDataSource ID="sdsRegulation" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                    SelectCommand="SELECT RegulationID, RegulationName, RegulationCode FROM Regulation"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>Notification Month:
            </td>
            <td>
                <telerik:RadTextBox ID="rtbNotificationMonth" runat="server">
                </telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td>Notification Year:
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
            <td>Description To Display in TSheet:
            </td>
            <td>
                <telerik:RadTextBox ID="rtbDescriptionForResult" runat="server" TextMode="MultiLine"
                    ShouldResetWidthInPixels="true" Width="300px">
                </telerik:RadTextBox>
                <%-- <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="rtbDescriptionForResult"
                    ErrorMessage="*" ForeColor="Red"  SetFocusOnError="true"></asp:RequiredFieldValidator>--%>
            </td>
        </tr>
        <tr>
            <td>For Batches:
            </td>
            <td>
                <asp:CheckBoxList ID="cblBatches" runat="server" RepeatDirection="Horizontal" RepeatColumns="4"
                    DataSourceID="sdsBatchYears" DataTextField="BatchYearValue" DataValueField="BatchYearID">
                </asp:CheckBoxList>
                <asp:SqlDataSource ID="sdsBatchYears" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                    SelectCommand="SELECT BatchYearID, BatchYearValue FROM BatchYear"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>Apply Jumbling:
            </td>
            <td>
                
               <asp:CheckBox ID="cbApplyJumbling" runat="server"  />
            </td>
        </tr>
        <tr>
            <td>Notification Start Date:
            </td>
            <td>
                <%--<telerik:RadDateTimePicker ID="rdtpNotificationStartDate" runat="server" >                    
                </telerik:RadDateTimePicker>--%>
                <telerik:RadDatePicker ID="rdtpNotificationStartDate" runat="server"></telerik:RadDatePicker>
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
            <td>Late Fee1 Start Date:
            </td>
            <td>
                <telerik:RadDatePicker ID="rdtpLateFee1StartDate" runat="server">
                </telerik:RadDatePicker>
                <%-- <telerik:RadDateTimePicker ID="rdtpLateFee1StartDate" runat="server">
                </telerik:RadDateTimePicker>--%>
            </td>
        </tr>
        <tr>
            <td>Late Fee1:
            </td>
            <td>
                <telerik:RadNumericTextBox ID="rntbNotificationLateFee1" runat="server">
                </telerik:RadNumericTextBox>
            </td>
        </tr>
        <tr>
            <td>Late Fee2 Start Date:
            </td>
            <td>
                <%--<telerik:RadDateTimePicker ID="rdtpLateFee2StartDate" runat="server">
                </telerik:RadDateTimePicker>--%>
                <telerik:RadDatePicker ID="rdtpLateFee2StartDate" runat="server">
                </telerik:RadDatePicker>
            </td>
        </tr>
        <tr>
            <td>Late Fee2:
            </td>
            <td>
                <telerik:RadNumericTextBox ID="rntbNotificationLateFee2" runat="server">
                </telerik:RadNumericTextBox>
            </td>
        </tr>
        <tr>
            <td>Notification End Date:
            </td>
            <td>
                <%--<telerik:RadDateTimePicker ID="rdtpNotificationEndDate" runat="server">
                </telerik:RadDateTimePicker>--%>
                <telerik:RadDatePicker ID="rdtpNotificationEndDate" runat="server">
                </telerik:RadDatePicker>
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
