using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace JntuApp.admin
{
    public partial class ManageExamTimeTable : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
        }

        protected void sdsSubjects_Updated(object sender, SqlDataSourceStatusEventArgs e)
        {

            
        }

        protected void rgTimeTable_UpdateCommand(object sender, GridCommandEventArgs e)
        {

        }

        protected void rgTimeTable_ItemUpdated(object sender, GridUpdatedEventArgs e)
        {
           // rgTimeTable.MasterTableView.Rebind();
            e.KeepInEditMode = false;
            
        }

        //protected void rgTimeTable_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        //{
        //    //if (e.Item is GridEditableItem)
        //    //{
        //    //    e.Item.Edit = true;
        //    //}
        //}

        //protected void rgTimeTable_PreRender(object sender, EventArgs e)
        //{
        //    //foreach (GridItem item in rgTimeTable.MasterTableView.DetailTables[0].Items)
        //    //{
        //    //    if (item.HasChildItems)
        //    //    {
        //    //        //GridTableView childTable = (GridTableView)item.ChildItem.NestedTableViews[0];

        //    //        //foreach (GridDataItem childitem in childTable.Items)
        //    //        //{

        //    //        //    //Check for the newly inserted row 
        //    //        //    //and set in edit mode 
        //    //        //    childitem.Edit = true;
        //    //        //}
        //    //    }

        //    //}


        //    ////foreach (GridItem item in RadGrid1.MasterTableView.Items)
        //    ////{
        //    ////    if (item is GridEditableItem)
        //    ////    {
        //    ////        GridEditableItem editableItem = item as GridDataItem;
        //    ////        editableItem.Edit = true;
        //    ////    }
        //    ////}
        //    ////RadGrid1.Rebind();

        //    rgTimeTable.MasterTableView.Rebind();



        //    foreach (GridDataItem gdi in rgTimeTable.MasterTableView.Items)
        //    {
        //        if (gdi.ChildItem.NestedTableViews.Length > 0)
        //        {
        //            foreach (GridTableView view in gdi.ChildItem.NestedTableViews)
        //            {
        //                //if (rgTimeTable.EditIndexes.Count > 0)
        //                //{
        //                foreach (GridDataItem gdi2 in view.Items)
        //                {
        //                    gdi2.Edit = true;
        //                }
        //                //view.Rebind() throws NullPointerException
        //                //}
        //            }
        //        }
        //    }
        //}

        //protected void rgtt_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
        //{
        //    if (e.Item is GridEditableItem)
        //    {
        //        e.Item.Edit = true;
        //    }
        //}
        //protected void rgtt_PreRender(object sender, EventArgs e)
        //{
        //    foreach (GridItem item in rgtt.MasterTableView.Items)
        //    {
        //        if (item is GridEditableItem)
        //        {
        //            GridEditableItem editableItem = item as GridDataItem;
        //            editableItem.Edit = true;
        //        }
        //    }
        //    BindData();
           
        //}

        //protected void rcbNotification_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        //{
        //    BindData();
           
        //}

        //private void BindData()
        //{
        //    rgtt.DataSource = sdsBranches.Select(DataSourceSelectArguments.Empty);
        //    rgtt.DataBind();
        //}

    }
}