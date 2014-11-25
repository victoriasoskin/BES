using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Media;

namespace WebPWI1
{
    public partial class Test10 : CommonPage
    {

        protected void Page_Error(object sender, EventArgs e)
        {
            writeErrorlog();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ServiceTypeID"] == null) Response.Redirect("~/CustEventReport.aspx;");
            if (!IsPostBack)
            {
                LoadQestions((int)Session["ServiceTypeID"], 210);
                DisplayFormat(sender, e,Page);
                Session["FormType"] = 210;
            }
        }
        protected void Next_Click(object sender, EventArgs e)
        {
            if (Session["TempValue"] == null)
            {
                Feedback.Text = " אנא בחר באחד הערכים בתשובה לשאלה";
                Feedback.Visible = true;

                return;
            }
    
            NextStep();
        }

        protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["TempValue"] = Convert.ToInt32(RadioButtonList1.SelectedValue);
            Feedback.Visible = false;

            RadioButtonList1.ClearSelection();

        }

        protected void Back_Click(object sender, EventArgs e)
        {
            StepBack(Page);
        }
        protected void hint_PreRender(object sender, System.EventArgs e)
        {
            ImageButton ib = (ImageButton)sender;
            PreHint();
            //       ib.Visible = PreHint(ImgHint);
        }
        protected void rbl_PreRender(object sender, System.EventArgs e)
        {
            RadioButtonList rbl = (RadioButtonList)sender;
            rbl.ClearSelection();
            try
            {
                string session_key = string.Format("Test_A{0}", Session["QUestionID"]);
                ListItem li=rbl.Items.FindByValue(Session[session_key].ToString());
                if (li != null)
                {
                    li.Selected = true;
                    Session["TempValue"] = li.Value;
                    rbl.ClearSelection();
                    rbl.SelectedValue = li.Value;
                }
                else
                {
                    Session["TempValue"] = null;
                    Session[session_key] = null;
                    rbl.ClearSelection();
                }
            }
            catch (Exception ex)
            {
            }
        }
    }
}