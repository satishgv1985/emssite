<%@ Page Title="" Language="C#" MasterPageFile="~/JntuSite.Master" AutoEventWireup="true"
    CodeBehind="ExternalMarksSingleEntry.aspx.cs" Inherits="JntuApp.ExternalMarksSingleEntry" %>

<%@ Register Src="~/MarksEntry.ascx" TagName="MarksEntry" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>External Marks - Single Entry</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc:MarksEntry ID="ucMarksEntry" runat="server" entry="Single" marksType="External" />
</asp:Content>
