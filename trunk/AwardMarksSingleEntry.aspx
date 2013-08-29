<%@ Page Title="" Language="C#" MasterPageFile="~/JntuSite.Master" AutoEventWireup="true"
    CodeBehind="AwardMarksSingleEntry.aspx.cs" Inherits="JntuApp.AwardMarksSingleEntry" %>

<%@ Register Src="~/UserControls/HT_LabMarks.ascx" TagName="HT_LabMarks" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Award Marks - Single Entry</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc:HT_LabMarks ID="ucLabMarksSingleEntry" runat="server" EntryType="single" />
</asp:Content>
