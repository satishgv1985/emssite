<%@ Page Title="JNTUAEMS :: Generate D - Form" Language="C#" MasterPageFile="~/CollegeSite.Master" AutoEventWireup="true"
    CodeBehind="UploadDForm.aspx.cs" Inherits="JntuCollegeEMS.college.upload.UploadDForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <script type="text/javascript">
        function AskForConfirmation(sender, args) {
            var callBackFunction = Function.createDelegate(sender, function (shouldSubmit) {
                if (shouldSubmit) {
                    this.click();
                }
            });

            var text = "Are you Sure to Upload?";
            radconfirm(text, callBackFunction, 300, 160, null, "Confirm");
            args.set_cancel(true);
        }
    </script>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
         <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true">
          </telerik:RadWindowManager>
    <table border="0" class="headingTable">
        <tr>
            <td>
                <telerik:RadButton ID="RadButton1" runat="server" Text="Upload D - Form" AutoPostBack="false"
                    Style="top: 0px; left: 0px; height: 21px;">
                </telerik:RadButton>
            </td>
        </tr>
    </table>
    <br />
    <table class="notificationTable">
        <tr>
            <td>Select Notification:
            </td>
            <td>
                  <telerik:RadComboBox ID="rcbNotification" runat="server" 
                    DataTextField="Description" DataValueField="ExamNotificationID"
                    AutoPostBack="True" EmptyMessage="--Select Notification--"
                    Width="400px" OnSelectedIndexChanged="rcbNotification_SelectedIndexChanged" DataSourceID="odsNotifications">
                </telerik:RadComboBox>
                <asp:ObjectDataSource ID="odsNotifications" runat="server" SelectMethod="GetNotificationsByCollegeID" TypeName="JntuCollegeEMS.HelperClass">
                    <SelectParameters>
                        <asp:SessionParameter Name="collegeID" SessionField="CollegeID" Type="Byte" />
                    </SelectParameters>
                </asp:ObjectDataSource>
               <%-- <asp:SqlDataSource ID="sdsExamNotification" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                    SelectCommand="SELECT ExamNotificationID, Description FROM ExamNotification"></asp:SqlDataSource>--%>
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
        <tr>
            <td colspan="2">Note: D-Form for a Subject can be uploaded only between Exam Start Time and 1hour after Exam End Time.
            <br />
                Example:<br />
                If Exam "A" is from 10AM to 1PM today then D-Form can be uploaded from 10AM to 2PM on the same day.
            </td>
        </tr>
    </table>
    <table class="innerTable">       

        <tr>
            <td>Select Branch:
            </td>
            <td>
                <telerik:RadComboBox ID="rcbBranches" runat="server" AutoPostBack="true" DataSourceID="sdsBranches"
                    DataTextField="BranchName" DataValueField="BranchID" EmptyMessage="--Select Branch--"
                    Width="300px" OnSelectedIndexChanged="rcbBranches_SelectedIndexChanged">
                </telerik:RadComboBox>
                <asp:SqlDataSource ID="sdsBranches" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                    SelectCommand="SELECT BranchID, BranchName FROM Branch where CourseID IN(SELECT CourseID FROM ExamNotification WHERE ExamNotificationID=@ExamNotificationID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="rcbNotification" Name="ExamNotificationID" />
                    </SelectParameters>
                </asp:SqlDataSource>

            </td>
        </tr>
        <tr>
            <td>Select Examination Subject:
            </td>
            <td>
                <telerik:RadComboBox ID="rcbExaminationSubjects" runat="server" AutoPostBack="true"
                    DataTextField="SubjectName" DataValueField="SubjectID" EmptyMessage="--Select Subject--"
                    Width="300px" OnSelectedIndexChanged="rcbExaminationSubjects_SelectedIndexChanged">
                </telerik:RadComboBox>

            </td>
        </tr>
         <tr>
            <td colspan="2" class="statusMessage">
                <br />
                <asp:Label ID="lblMessage" runat="server" Visible="false" Text="Data Saved Successfully. Please select another Branch and Subject to Enter again."></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2" id="tdStudents" runat="server" visible="false">

                <table border="0" class="innerTable">
                    <tr>
                        <td style="width:52%">
                            <b>Students Writing the Selected Exam Today</b>
                        </td>
                        <td>
                            <b>Absent Students</b>

                        </td>
                    </tr>
                    <tr>
                        <td>Search HallTicketNo: 
                                            <telerik:RadTextBox ID="RadTextBox1"
                                                ClientEvents-OnKeyPress="filterListBox"
                                                runat="server">
                                            </telerik:RadTextBox>
                        </td>
                        <td>Following Students are treated as absent for the above Exam
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadListBox ID="rlbExamWritingStudents" runat="server" DataSourceID="sdsPresentStudents"
                                DataKeyField="StudentID" DataSortField="HallTicketNumber" DataTextField="HT_Name"
                                DataValueField="StudentID" AllowTransfer="True" TransferToID="rlbRightListStudents"
                                SelectionMode="Multiple" Width="100%" Height="300" AllowTransferOnDoubleClick="false"
                                EmptyMessage="No Students are writing the selected subject">
                                <ButtonSettings TransferButtons="All" VerticalAlign="Middle" />
                            </telerik:RadListBox>
                            <asp:SqlDataSource ID="sdsPresentStudents" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                                SelectCommand="select s.StudentName,s.StudentID,s.HallTicketNumber,s.HallTicketNumber + ' - ' + s.StudentName AS HT_Name 
                                        from studentsubjectregistration ssr join Student s on ssr.StudentID=s.StudentID
                                        where ssr.ExamNotificationID=@ExamNotificationID
                                            and ssr.SubjectID=@SubjectID 
                                            and ssr.ExamCenterCollegeID=@ExamCenterCollegeID
                                            and s.StudentID not in
                                            (select DISTINCT s.StudentID from StudentExternalMarks sem
                                            join Student s on sem.StudentID=s.StudentID
                                            join StudentSubjectRegistration ssr on ssr.StudentID=s.StudentID
                                            where sem.ExamNotificationID=@ExamNotificationID  
                                            and sem.ExternalMarks=-1
                                            and ssr.ExamCenterCollegeID=@ExamCenterCollegeID                                        
                                            and sem.SubjectID=@SubjectID) 
                                        order by HT_Name">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="rcbNotification" Name="ExamNotificationID" />
                                    <asp:ControlParameter ControlID="rcbExaminationSubjects" Name="SubjectID" />
                                    <asp:SessionParameter Name="ExamCenterCollegeID" Type="Int16" SessionField="CollegeID" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <script type="text/javascript">
                                function filterListBox(sender, e) {
                                    var list = $find("<%= rlbExamWritingStudents.ClientID %>");
                                    var searchText = sender.get_value() + e.get_keyCharacter();
                                    var items = list.get_items();
                                    for (var i = 0; i < items.get_count() ; i++) {
                                        var item = items.getItem(i);
                                        if (item.get_text().toLowerCase().startsWith(searchText.toLowerCase())) {
                                            item.select();
                                            item.ensureVisible();
                                            item.scrollIntoView;
                                            break;
                                        }
                                    }
                                }
                            </script>
                        </td>
                        <td>
                            <telerik:RadListBox ID="rlbRightListStudents" runat="server" DataKeyField="StudentID" DataSortField="StudentName"
                                DataSourceID="sdsAbsentStudents" DataTextField="HT_Name" DataValueField="StudentID"
                                SelectionMode="Multiple" Width="100%" Height="300"
                                EmptyMessage="Select Students from Left box">
                            </telerik:RadListBox>
                            <asp:SqlDataSource ID="sdsAbsentStudents" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                                SelectCommand="select DISTINCT s.StudentName,s.StudentID,s.HallTicketNumber,s.HallTicketNumber + ' - ' + s.StudentName AS HT_Name 
                                        from StudentExternalMarks sem join Student s on sem.StudentID=s.StudentID
                                        join StudentSubjectRegistration ssr on ssr.StudentID=s.StudentID
                                        where sem.ExamNotificationID=@ExamNotificationID  
                                        and sem.ExternalMarks=-1                                                                              
                                        and sem.SubjectID=@SubjectID
                                        and ssr.ExamCenterCollegeID=@ExamCenterCollegeID
                                        order by HT_Name">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="rcbNotification" Name="ExamNotificationID" />
                                    <asp:ControlParameter ControlID="rcbExaminationSubjects" Name="SubjectID" />
                                    <asp:SessionParameter Name="ExamCenterCollegeID" Type="Int16" SessionField="CollegeID" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>

            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <telerik:RadButton ID="rbUpload" runat="server" Text="Upload" Enabled="false" OnClientClicking="AskForConfirmation" OnClick="rbUpload_Click">
                </telerik:RadButton>
            </td>
        </tr>
    </table>
</asp:Content>
