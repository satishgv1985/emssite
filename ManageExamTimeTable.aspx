<%@ Page Title="" Language="C#" MasterPageFile="~/JntuSite.Master" AutoEventWireup="true" CodeBehind="ManageExamTimeTable.aspx.cs"
    MaintainScrollPositionOnPostback="true" Inherits="JntuApp.admin.ManageExamTimeTable" %>

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

        <%--<tr>
            <td>Select Branch:
            </td>
            <td>
                <telerik:RadComboBox ID="rcbBranches" runat="server" DataSourceID="sdsBranch"
                    DataTextField="BranchName" DataValueField="BranchID" AutoPostBack="true">
                    <Items>
                        <telerik:RadComboBoxItem Text="--Select Notification--" />
                    </Items>
                </telerik:RadComboBox>
                <asp:SqlDataSource ID="sdsBranch" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                    SelectCommand="SELECT BranchID, BranchName FROM Branch where CourseID=@courseID">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="rcbNotification" Name="CourseID" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>--%>

        <tr>
            <td colspan="2">
                <asp:SqlDataSource ID="sdsBranches" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                    SelectCommand="SELECT  BranchID, BranchName, BranchCode FROM Branch where CourseID IN(SELECT CourseID FROM ExamNotification WHERE ExamNotificationID=@ExamNotificationID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="rcbNotification" Name="ExamNotificationID" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:SqlDataSource ID="sdsSubjects" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                    SelectCommand="select distinct s.SubjectID, s.SubjectCode,s.SubjectName,s.SubjectOrder,st.SubjectTypeFullName,
                                    RegularExamFee,SupplementaryExamFee,StartTime,EndTime
                                    from ExamNotificationSubject ens
                                    join Subject s on ens.SubjectID=s.SubjectID
                                    join SubjectType st on st.SubjectTypeID=s.SubjectTypeID
                                    where ExamNotificationID=@ExamNotificationID and BranchId=@BranchID
                                    order by SubjectOrder"
                    UpdateCommand="update ExamNotificationSubject set StartTime=@startTime, EndTime=@endTime, 
                                    RegularExamFee=@RegularExamFee,SupplementaryExamFee=@SupplementaryExamFee WHERE
                                ExamNotificationID=@ExamNotificationID and SubjectID in
                                (select SubjectID FROM Subject where SubjectCode=@subjectCode)"
                    OnUpdated="sdsSubjects_Updated">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="rcbNotification" Name="ExamNotificationID" />
                        <asp:ControlParameter ControlID="rgTimeTable" Name="BranchID" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="rcbNotification" Name="ExamNotificationID" />
                        <asp:Parameter Name="SubjectCode" />
                        <asp:Parameter Name="StartTime" DbType="DateTime" />
                        <asp:Parameter Name="EndTime" DbType="DateTime" />
                        <asp:Parameter Name="RegularExamFee" />
                        <asp:Parameter Name="SupplementaryExamFee" />
                    </UpdateParameters>
                </asp:SqlDataSource>

                <%-- <telerik:RadGrid ID="rgtt" runat="server" ShowHeader="true" AutoGenerateColumns="true"  OnPreRender="rgtt_PreRender">
                    <MasterTableView AllowAutomaticUpdates="true" EditMode="InPlace" ></MasterTableView>
                </telerik:RadGrid>--%>

                <telerik:RadGrid ID="rgTimeTable" runat="server" ShowHeader="true" AutoGenerateColumns="false"
                    DataSourceID="sdsBranches" AllowAutomaticUpdates="true" MasterTableView-EditMode="InPlace" MasterTableView-CommandItemDisplay="TopAndBottom"
                    OnUpdateCommand="rgTimeTable_UpdateCommand" OnItemUpdated="rgTimeTable_ItemUpdated" ShowStatusBar="true">
                    <MasterTableView DataSourceID="sdsBranches" DataKeyNames="BranchID" HierarchyDefaultExpanded="true" GridLines="None">
                        <CommandItemSettings ShowRefreshButton="true"  />
                        
                        <Columns>
                            <telerik:GridBoundColumn DataField="BranchID" FilterControlAltText="Filter BranchID column"
                                HeaderText="BranchID" ReadOnly="True" SortExpression="BranchID" UniqueName="BranchID"
                                Visible="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="BranchCode" FilterControlAltText="Filter BranchCode column"
                                HeaderText="BranchCode" SortExpression="BranchCode" UniqueName="BranchCode" ItemStyle-Width="50px" ReadOnly="false">
                                <ItemStyle Font-Bold="true" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="BranchName" FilterControlAltText="Filter BranchName column" ItemStyle-Width="300Px"
                                HeaderText="BranchName" SortExpression="BranchName" UniqueName="BranchName">
                                <ItemStyle Font-Bold="true" />
                            </telerik:GridBoundColumn>
                        </Columns>
                        <DetailTables>
                            <telerik:GridTableView DataSourceID="sdsSubjects" DataKeyNames="SubjectID,SubjectCode" AutoGenerateColumns="false"
                                AllowAutomaticUpdates="true" EditMode="InPlace" ShowHeader="true">
                                <ParentTableRelation>
                                    <telerik:GridRelationFields DetailKeyField="BranchID" MasterKeyField="BranchID"></telerik:GridRelationFields>
                                </ParentTableRelation>
                                <Columns>
                                    <telerik:GridBoundColumn DataField="SubjectID" FilterControlAltText="Filter SubjectID column"
                                        HeaderText="SubjectID" ReadOnly="True" SortExpression="SubjectID" UniqueName="SubjectID"
                                        Visible="false">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SubjectCode" FilterControlAltText="Filter SubjectCode column" ItemStyle-Width="50Px"
                                        HeaderText="Subject Code" ReadOnly="True" SortExpression="SubjectCode" UniqueName="SubjectCode">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SubjectName" FilterControlAltText="Filter SubjectName column" ItemStyle-Width="200Px"
                                        HeaderText="Subject Name" ReadOnly="True" SortExpression="SubjectName" UniqueName="SubjectName">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SubjectOrder" FilterControlAltText="Filter SubjectID column" ItemStyle-Width="50Px"
                                        HeaderText="Subject Order" SortExpression="SubjectOrder" UniqueName="SubjectOrder" ReadOnly="true">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SubjectTypeFullName" FilterControlAltText="Filter SubjectTypeFullName column" ItemStyle-Width="50Px"
                                        HeaderText="Subject Type" ReadOnly="True" SortExpression="SubjectTypeFullName" UniqueName="SubjectTypeFullName">
                                    </telerik:GridBoundColumn>
                                    <telerik:GridNumericColumn DataField="RegularExamFee" ItemStyle-Width="50px" HeaderText="Regular Exam Fee" UniqueName="RegularExamFee">
                                    </telerik:GridNumericColumn>
                                    <telerik:GridNumericColumn DataField="SupplementaryExamFee" ItemStyle-Width="50px" HeaderText="Supplementary Exam Fee" UniqueName="SupplementaryExamFee">
                                    </telerik:GridNumericColumn>
                                    <telerik:GridDateTimeColumn DataField="StartTime" HeaderText="Exam Start Date & Time" ReadOnly="false"
                                        UniqueName="StartTime" PickerType="DateTimePicker">
                                    </telerik:GridDateTimeColumn>
                                    <telerik:GridDateTimeColumn DataField="EndTime" HeaderText="Exam End Date & Time" ReadOnly="false"
                                        UniqueName="EndTime" PickerType="DateTimePicker">
                                    </telerik:GridDateTimeColumn>

                                    <telerik:GridEditCommandColumn ButtonType="ImageButton" HeaderText="Edit">
                                        <HeaderStyle Width="20px" />
                                        <ItemStyle CssClass="MyImageButton" />
                                    </telerik:GridEditCommandColumn>
                                </Columns>
                            </telerik:GridTableView>
                        </DetailTables>

                    </MasterTableView>
                </telerik:RadGrid>




            </td>
        </tr>
    </table>
</asp:Content>
