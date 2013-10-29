<%@ Page Title="" Language="C#" MasterPageFile="~/CollegeSite.Master" AutoEventWireup="true" CodeBehind="AddStudentInCollege.aspx.cs" Inherits="JntuCollegeEMS.college.AddStudentInCollege" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<title>Add Student To Your College</title>
	<style type="text/css">
		.RadUpload input.ruFakeInput {
			display: none;
		}

		.RadUpload input.ruBrowse {
			width: 115px;
		}

		.RadUpload span.ruFileWrap input.ruButtonHover {
			background-position: 100% -46px;
		}

		.RadUpload input.ruButton {
			background-position: 0 -46px;
		}

		.invalid {
			color: Red;
		}

		.binary-image {
			margin-bottom: 5px;
		}
	</style>
	<style type="text/css">
		qsfClear:after {
			clear: both;
			content: "";
			display: block;
			height: 0;
			visibility: hidden;
		}

		.demoArea {
			background: url("qsfBigHolderHomeBgr.gif") repeat scroll 0 -45px #FFFFFF;
			border-radius: 0 0 5px 5px;
			color: #001119;
			padding-top: 15px;
			z-index: 1;
		}

		.qsfClear {
			display: block;
		}
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
	<table border="0" class="headingTable">
		<tr>
			<td colspan="2">
				<telerik:RadButton ID="RadButton1" runat="server" Text="Student Registration Form - Single Entry"
					Style="top: 0px; left: 0px; height: 21px;" AutoPostBack="false">
				</telerik:RadButton>
			</td>
		</tr>
		<tr id="trMessage" runat="server">
			<td colspan="2" class="statusMessage">
				<asp:Label ID="lblMessage" runat="server"></asp:Label>
			</td>
		</tr>
	</table>
	<table class="innerTable">
		<tr>
			<td>
				<table border="0">
					<tr>
						<td>
							<asp:Label ID="lblHallTicketNumber" Text="Hall Ticket Number" runat="server"></asp:Label>
						</td>
						<td>
							<telerik:RadTextBox ID="trtHallTicketnumber" runat="server" MaxLength="10">
							</telerik:RadTextBox>&nbsp;*
						<asp:RequiredFieldValidator ID="rfvHallTicketNumber" runat="server" ControlToValidate="trtHallTicketnumber"
							ErrorMessage="* Enter Hall Ticket Number" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
						</td>
					</tr>
					<%--     <tr>
							<td>
								<asp:Label ID="lblregisterDate" Text="Register Date" runat="server"></asp:Label>
							</td>
							<td>
								<telerik:RadDatePicker ID="trdRegisterDate" runat="server" Width="140px" AutoPostBack="true" 
									DateInput-EmptyMessage="RegisterDate" MinDate="01/04/2012" 
									MaxDate="01/06/2012" SelectedDate="1/04/2012">
									<Calendar ID="Calendar1" runat="server">
										<SpecialDays>
											<telerik:RadCalendarDay Repeatable="Today" ItemStyle-CssClass="rcToday" />
										</SpecialDays>
									</Calendar>
								</telerik:RadDatePicker>
							</td>
						</tr>--%>
					<tr>
						<td>
							<asp:Label ID="lblStudentname" Text="Student Name(as per SSC):" runat="server"></asp:Label>
						</td>
						<td>
							<telerik:RadTextBox ID="trtStudentName" runat="server" Width="190">
							</telerik:RadTextBox>
							&nbsp;*
						<asp:RequiredFieldValidator ID="rfvStudentName" runat="server" ControlToValidate="trtStudentName"
							ErrorMessage="* Enter Student Name" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
						</td>
					</tr>
					<tr>
						<td>
							<asp:Label ID="lblFatherName" Text="Father Name(as per SSC):" runat="server"></asp:Label>
						</td>
						<td>
							<telerik:RadTextBox ID="trtFatherName" runat="server" Width="190">
							</telerik:RadTextBox>
							&nbsp;*
						   <asp:RequiredFieldValidator ID="rfvFatherName" runat="server" ControlToValidate="trtFatherName"
							   ErrorMessage="* Enter Father Name" SetFocusOnError="true" ForeColor="Red"></asp:RequiredFieldValidator>
						</td>
					</tr>
					<tr>
						<td>
							<asp:Label ID="lblMotherName" Text="Mother Name" runat="server"></asp:Label>
						</td>
						<td>
							<telerik:RadTextBox ID="trtMotherName" runat="server" Width="190">
							</telerik:RadTextBox>
						</td>
					</tr>
					<tr>
						<td>
							<asp:Label ID="Gender" Text="Gender" runat="server">
							</asp:Label>
						</td>
						<td>
							<telerik:RadComboBox ID="trcGender" runat="server" Width="100">
								<Items>
									<telerik:RadComboBoxItem runat="server" Text="Male" Value="0" />
									<telerik:RadComboBoxItem runat="server" Text="Female" Value="1" />
								</Items>
							</telerik:RadComboBox>
						</td>
					</tr>
					<tr>
						<td>
							<asp:Label ID="lblDateOfBirth" Text="Date Of Birth" runat="server"></asp:Label>
						</td>
						<td>
							<telerik:RadDatePicker ID="trdDateOfBirth" runat="server" Width="130px" AutoPostBack="false"
								DateInput-EmptyMessage="Date Of Birth" MinDate="01/01/1980" MaxDate="01/01/2012"
								SelectedDate="1984-07-16">
								<Calendar ID="Calendar2" runat="server">
									<SpecialDays>
										<telerik:RadCalendarDay Repeatable="Today" ItemStyle-CssClass="rcToday">
											<ItemStyle CssClass="rcToday"></ItemStyle>
										</telerik:RadCalendarDay>
									</SpecialDays>
								</Calendar>
								<DateInput DisplayDateFormat="M/d/yyyy" DateFormat="M/d/yyyy" AutoPostBack="True"
									EmptyMessage="Date Of Birth" LabelWidth="40%" SelectedDate="1984-07-16">
								</DateInput>
								<DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
							</telerik:RadDatePicker>
						</td>
					</tr>
					<tr>
						<td>
							<asp:Label ID="lblRegulation" Text="Regulation" runat="server"></asp:Label>
						</td>
						<td>
							<telerik:RadComboBox ID="rcbRegulation" runat="server" DataSourceID="sdsRegulation" Width="130"
								DataTextField="RegulationName" DataValueField="RegulationID" EmptyMessage="--Select Regulation--">
							</telerik:RadComboBox>
							&nbsp;*
							<asp:SqlDataSource ID="sdsRegulation" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
								SelectCommand="SELECT RegulationID, RegulationName, RegulationCode FROM Regulation"></asp:SqlDataSource>
							<asp:RequiredFieldValidator ID="rfvRegulation" runat="server" ErrorMessage="* Please Select Regulation" 
								ForeColor="Red" ControlToValidate="rcbRegulation"></asp:RequiredFieldValidator>
						</td>
					</tr>
					<%--<tr>
					<td>
						<asp:Label ID="lblCourse" Text="Courses" runat="server"></asp:Label>
					</td>
					<td>
						<telerik:RadComboBox ID="trcCourse" runat="server" DataSourceID="sdsCollegeCourses"
							DataTextField="CourseName" DataValueField="CourseID" AutoPostBack="true" OnSelectedIndexChanged="trcCourse_SelectedIndexChanged"
							EmptyMessage="--Select Course--" CausesValidation="false">
						</telerik:RadComboBox>
						<asp:SqlDataSource ID="sdsCollegeCourses" runat="server" ConnectionString="<%$ ConnectionStrings:JntuDBConnectionString %>"
							SelectCommand="SELECT CourseID, CourseName, CourseCode FROM Course WHERE (CourseID IN (SELECT CourseID FROM CollegeCourse WHERE (CollegeID = @CollegeID))) Order By CourseName">
							<SelectParameters>
								<asp:ControlParameter ControlID="hfCollegeID" Name="CollegeID" PropertyName="Value" />
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
							EmptyMessage="--Select Branch--" AutoPostBack="True" CausesValidation="false" Width="300">
						</telerik:RadComboBox>
					</td>
				</tr>--%>
					<%--<tr>
						<td>
							<asp:Label ID="lblYear" Text="Year Of " runat="server"></asp:Label>
						</td>
						<td>
							<telerik:RadMonthYearPicker ID="rmypMonthYear" runat="server" ZIndex="30001">
							</telerik:RadMonthYearPicker>
							
						</td>
					</tr>--%>

					<%--  <tr>
							<td>
								<asp:Label ID="lblEmail" Text="Email" runat="server"></asp:Label>
							</td>
							<td>
								<telerik:RadTextBox ID="trtEmail" runat="server">
								</telerik:RadTextBox>
							</td>
						</tr>
						<tr>
							<td>
								<asp:Label ID="lblMobileNo" Text="Mobile No" runat="server"></asp:Label>
							</td>
							<td>
								<telerik:RadTextBox ID="trtMobileNo" runat="server">
								</telerik:RadTextBox>
							</td>
						</tr>--%>
				</table>
			</td>
			<td width="210" valign="top">
				<table width="100%">
					<tr>
						<td>
							<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
								<AjaxSettings>
									<telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
										<UpdatedControls>
											<telerik:AjaxUpdatedControl ControlID="Thumbnail" />
										</UpdatedControls>
									</telerik:AjaxSetting>
								</AjaxSettings>
							</telerik:RadAjaxManager>
							<telerik:RadScriptBlock ID="rsbImageUpload" runat="server">
								<script type="text/javascript">
									function fileUploaded(sender, args) {

										$find("<%=RadAjaxManager1.ClientID %>").ajaxRequest();
										$telerik.$(".invalid").html("");
										setTimeout(function () {
											sender.deleteFileInputAt(0);
										}, 10);
									}

									function validationFailed(sender, args) {
										$telerik.$(".invalid")
					.html("Invalid extension, please choose an image file");
										sender.deleteFileInputAt(0);
									}
								</script>
							</telerik:RadScriptBlock>
							<div class="upload-panel" style="width: 210px">
								<%-- For the purpose of this demo the files are discarded.
			 In order to store the uploaded files permanently set the TargetFolder property to a valid location. --%>
								<telerik:RadBinaryImage runat="server" Width="200px" Height="150px" ResizeMode="Fit"
									ID="Thumbnail" ImageUrl="~/images/avatar.png" AlternateText="Thumbnail" CssClass="binary-image" />
								<%--<asp:RequiredFieldValidator ID="rfvPhoto" runat="server" ErrorMessage="* Photo is Mandatory." 
									ControlToValidate="Thumbnail" ForeColor="Red"></asp:RequiredFieldValidator>--%>
								<span class="invalid"></span>
								<telerik:RadAsyncUpload runat="server" ID="AsyncUpload1" MaxFileInputsCount="1" OnClientFileUploaded="fileUploaded"
									OnFileUploaded="AsyncUpload1_FileUploaded" AllowedFileExtensions="jpeg,jpg,gif,png,bmp"
									Width="210" OnClientValidationFailed="validationFailed">
									<Localization Select="Choose Photo" />
								</telerik:RadAsyncUpload>
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="text-align: center;">
				<table border="0" cellpadding="15" width="100%">
					<tr>
						<td>
							<telerik:RadButton ID="trbSave" Text="SAVE" runat="server" OnClick="rbSave_Click">
							</telerik:RadButton>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr id="trMessagebelow" runat="server">
			<td colspan="2" class="statusMessage">
				<asp:Label ID="lblBelowMessage" runat="server"></asp:Label>
			</td>
		</tr>
	</table>
</asp:Content>
