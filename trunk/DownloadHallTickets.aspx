<%@ Page Title="" Language="C#" MasterPageFile="~/CollegeSite.Master" AutoEventWireup="true"
    CodeBehind="DownloadHallTickets.aspx.cs" Inherits="JntuCollegeEMS.GenerateHallTickets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Download Hall Tickets</title>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="headingTable">
        <tr>
            <td colspan="2">
                <telerik:RadButton ID="rbHeading" runat="server" Style="top: 0px; left: 0px; height: 21px;" AutoPostBack="false"
                    Text="Download Hall Tickets">
                </telerik:RadButton>
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
                    Width="400" OnSelectedIndexChanged="rcbNotification_SelectedIndexChanged">
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
    <table class="innerTable">
        <%--  <tr>
            <td>
                <asp:Label ID="lblBranch" Text="Select Branch:" runat="server"></asp:Label>
            </td>
            <td>
                <telerik:RadComboBox ID="rcbBranches" runat="server" DataSourceID="sdsBranches" DataTextField="BranchName"
                    DataValueField="BranchID" EmptyMessage="--Select Course First--" Width="300">
                </telerik:RadComboBox>
                <asp:SqlDataSource ID="sdsBranches" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                    SelectCommand="SELECT BranchID, BranchCode, BranchName, CourseID FROM Branch WHERE (CourseID = @CourseID) order by BranchName">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="rcbCourses" Name="CourseID" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblSemester" Text="Select Semester:" runat="server"></asp:Label>
            </td>
            <td>
                <telerik:RadComboBox ID="rcbSemesters" runat="server" DataSourceID="sdsSemesters"
                    DataTextField="SemesterName" DataValueField="SemesterID" EmptyMessage="--Select Course First--">
                </telerik:RadComboBox>
                <asp:SqlDataSource ID="sdsSemesters" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                    SelectCommand="SELECT [SemesterID], [SemesterName], [SemesterYear], [CourseID], [SemesterNumber] FROM [Semester] WHERE ([CourseID] = @CourseID) ORDER BY [SemesterYear], [SemesterNumber]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="rcbCourses" Name="CourseID" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>--%>
        <tr>
            <td colspan="2" style="text-align: center;">
                <telerik:RadButton ID="rbDownload" Target="_blank" Enabled="false" runat="server" Text="Download" OnClick="rbDownload_Click">
                </telerik:RadButton>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hfCollegeName" runat="server" />
    <asp:HiddenField ID="hfCollegeID" runat="server" />
</asp:Content>
