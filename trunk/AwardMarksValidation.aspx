<%@ Page Title="" Language="C#" MasterPageFile="~/JntuSite.Master" AutoEventWireup="true" CodeBehind="AwardMarksValidation.aspx.cs" Inherits="JntuApp.AwardMarksValidation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<table border="0" cellpadding="10" cellspacing="0" width="100%" id="tblMain" runat="server">
    <tr>
        <td colspan="2">
            <telerik:RadButton ID="rbHeading" runat="server" Style="top: 0px; left: 0px; height: 21px;" Text="Award Marks - Validation">
            </telerik:RadButton>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblCourse" Text="Courses" runat="server"></asp:Label>
        </td>
        <td>
            <telerik:RadComboBox ID="trcCourse" runat="server" DataSourceID="sdsCollegeCourses"
                EmptyMessage="--Select Course--" DataTextField="CourseName" DataValueField="CourseID"
                OnSelectedIndexChanged="trcCourse_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false">
            </telerik:RadComboBox>
            <asp:SqlDataSource ID="sdsCollegeCourses" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                SelectCommand="SELECT CourseID, CourseName, CourseCode FROM Course">
                <SelectParameters>
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblBranch" Text="Branch" runat="server"></asp:Label>
        </td>
        <td>
            <telerik:RadComboBox ID="trcBranch" runat="server" OnSelectedIndexChanged="trcBranch_SelectedIndexChanged"
                EmptyMessage="--Select Branch--" AutoPostBack="True">
            </telerik:RadComboBox>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblSemister" Text="Semester" runat="server"></asp:Label>
        </td>
        <td>
            <telerik:RadComboBox ID="trcSemister" runat="server" OnSelectedIndexChanged="trcSemister_SelectedIndexChanged"
                AutoPostBack="True" EmptyMessage="--Select Semester--">
            </telerik:RadComboBox>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="Label2" Text="Subjects" runat="server"></asp:Label>
        </td>
        <td>
            <telerik:RadComboBox ID="trcSubjects" runat="server" AutoPostBack="True" EmptyMessage="--Select Subject --">
            </telerik:RadComboBox>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblYear" Text="Year" runat="server"></asp:Label>
        </td>
        <td>
            <telerik:RadMonthYearPicker ID="RadMonthYearPicker" runat="server">
            </telerik:RadMonthYearPicker>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lblRegSupply" Text="Reg/Supply" runat="server"></asp:Label>
        </td>
        <td>
            <telerik:RadComboBox ID="trcRegSupply" runat="server">
                <Items>
                    <telerik:RadComboBoxItem runat="server" Text="Regular" Value="1" Selected="True" />
                    <telerik:RadComboBoxItem runat="server" Text="Supplementary" Value="2" />
                </Items>
            </telerik:RadComboBox>
        </td>
    </tr>
</table>

<table cellpadding="5">
        <tr>
            <td>
                <asp:Label ID="lblMessage" Font-Bold="true" runat="server">The following records are mismatched:</asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="rgAwardList" runat="server" AutoGenerateColumns="False" CellSpacing="0"
                    AllowAutomaticDeletes="True" AllowAutomaticUpdates="true" DataSourceID="sdsAwardList"
                    GridLines="None" AllowPaging="True">
                    <MasterTableView EditMode="InPlace" DataKeyNames="HT_ExtLabID"
                        DataSourceID="sdsAwardList">
                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                        <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column">
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </RowIndicatorColumn>
                        <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column">
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </ExpandCollapseColumn>
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton">
                                <HeaderStyle Width="20px" />
                                <ItemStyle CssClass="MyImageButton" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridBoundColumn DataField="HT_ExtLabID" DataType="System.Guid" FilterControlAltText="Filter HT_ExtLabID column"
                                HeaderText="HT_ExtLabID" ReadOnly="True" SortExpression="HT_ExtLabID" UniqueName="HT_ExtLabID"
                                Visible="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="HallTicketNumber" FilterControlAltText="Filter HallTicketNumber column"
                                HeaderText="HallTicketNumber" SortExpression="HallTicketNumber" UniqueName="HallTicketNumber">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Marks" FilterControlAltText="Filter Marks column"
                                HeaderText="Marks" SortExpression="Marks" UniqueName="Marks">
                            </telerik:GridBoundColumn>
                           
                            <telerik:GridButtonColumn ConfirmText="Delete this Entry?" ButtonType="ImageButton"
                                CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">
                                <HeaderStyle Width="20px" />
                                <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />
                            </telerik:GridButtonColumn>
                        </Columns>
                        <EditFormSettings>
                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                    <FilterMenu EnableImageSprites="False">
                    </FilterMenu>
                    <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_Default">
                    </HeaderContextMenu>
                </telerik:RadGrid>
                <asp:SqlDataSource ID="sdsAwardList" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                    SelectCommand="SELECT * FROM HT_ExtLab WHERE (BranchID = @BranchID) AND (CourseID = @CourseID) AND (ExamTypeID = @ExamTypeID) AND (SemesterID = @SemesterID) AND (SubjectID = @SubjectID)  AND (IsValid = 0)"
                    UpdateCommand="UPDATE [HT_ExtLab]
   SET 
      [HallTicketNumber] = @HallTicketNumber,
      [Marks] = @Marks,
      [IsValid] = 1 WHERE (HT_ExtLabID = @HT_ExtLabID)" DeleteCommand="DELETE HT_ExtLab WHERE (HT_ExtLabID = @HT_ExtLabID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="trcBranch" Name="BranchID" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="trcCourse" Name="CourseID" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="trcRegSupply" Name="ExamTypeID" PropertyName="SelectedValue"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="trcSemister" Name="SemesterID" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="trcSubjects" Name="SubjectID" PropertyName="SelectedValue" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Marks" />
                        <asp:Parameter Name="PaperCode" />
                        <asp:Parameter Name="HT_ExtLabID" />
                    </UpdateParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="HT_ExtLabID" />
                    </DeleteParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>
