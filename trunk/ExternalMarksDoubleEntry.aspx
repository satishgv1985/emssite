<%@ Page Title="" Language="C#" MasterPageFile="~/JntuSite.Master" AutoEventWireup="true"
    CodeBehind="ExternalMarksDoubleEntry.aspx.cs" Inherits="JntuApp.ExternalMarksDoubleEntry" %>

<%@ Register Src="~/MarksEntry.ascx" TagName="MarksEntry" TagPrefix="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>External Marks - Double Entry</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc:MarksEntry ID="ucMarksEntry" runat="server" entry="Double" marksType="External" />
</asp:Content>
