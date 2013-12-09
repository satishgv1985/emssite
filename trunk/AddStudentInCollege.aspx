<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RadPivotSample.aspx.cs" Inherits="JEMS2012.RadPivotSample" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <telerik:RadScriptManager ID="rsm" runat="server"></telerik:RadScriptManager>
            <telerik:RadButton ID="rbExportToExcel" runat="server" Text="Export To Excel" OnClick="rbExportToExcel_Click"></telerik:RadButton>
            <br />
            <br />
            <telerik:RadPivotGrid ID="rpgStudentInternalMarks" runat="server" DataSourceID="sdsStudentInternalMarks"
                ShowFilterHeaderZone="false" AllowFiltering="false" TotalsSettings-GrandTotalsVisibility="ColumnsOnly"> 
                <ExportSettings FileName="StudentInternalMarks" />
                
                <ClientSettings EnableFieldsDragDrop="false"></ClientSettings>
                <Fields>
                    <telerik:PivotGridColumnField DataField="SubjectName" UniqueName="SubjectName" Caption="SubjectName">
                    </telerik:PivotGridColumnField>

                    <telerik:PivotGridRowField DataField="HallTicketNumber" UniqueName="HallTicketNumber" Caption="HallTicketNumber">
                        <CellStyle Width="150px" />
                    </telerik:PivotGridRowField>
                    <telerik:PivotGridAggregateField DataField="InternalMarks" Aggregate="Sum" UniqueName="InternalMarks" Caption="Student Internal Marks">
                        
                    </telerik:PivotGridAggregateField>
                </Fields>
            </telerik:RadPivotGrid>
            <asp:SqlDataSource ID="sdsStudentInternalMarks" runat="server"
                ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
                SelectCommand="SELECT HallTicketNumber, StudentName, InternalMarks, SubjectID,
'('+SubjectCode+') '+SubjectName as 'SubjectName', SubjectCode, StudentID
                  FROM vwStudentInternalMarks"></asp:SqlDataSource>


        </div>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <telerik:RadPivotGrid ID="rpgStudentSubjectRegistrations" runat="server" DataSourceID="sdsStudentSubjectRegistrations"
            ShowFilterHeaderZone="false" AllowFiltering="false" TotalsSettings-GrandTotalsVisibility="ColumnsOnly">
            <ExportSettings FileName="StudentSubjectRegistrations" />

            <ClientSettings EnableFieldsDragDrop="false"></ClientSettings>
            <Fields>

                <telerik:PivotGridRowField DataField="HallTicketNumber" UniqueName="HallTicketNumber" Caption="HallTicketNumber">
                    <CellStyle Width="150px" />
                </telerik:PivotGridRowField>
                <telerik:PivotGridAggregateField DataField="SubjectName" Aggregate="Sum" UniqueName="SubjectName" Caption="Student SubjectName Marks">
                </telerik:PivotGridAggregateField>
            </Fields>
        </telerik:RadPivotGrid>
        <asp:SqlDataSource ID="sdsStudentSubjectRegistrations" runat="server"
            ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
            SelectCommand="SELECT top 70 [StudentID], [HallTicketNumber], [SubjectID], [StudentName], [RegOrSupply],
             [SubjectCode], [SubjectName],CollegeID FROM [vwStudentSubjectRegistrations] where collegeID=154"></asp:SqlDataSource>
    </form>
</body>
</html>

