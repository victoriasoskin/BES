using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Media;

namespace WebPWI1
{
    public partial class Test2 : CommonPage
    {
        //protected void Page_Error(object sender, EventArgs e)
        //{
        //    writeErrorlog();
        //}
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ServiceTypeID"] == null) Response.Redirect("~/CustEventReport.aspx");
            if (!IsPostBack)
            {

                LoadQestions((int)Session["ServiceTypeID"], 202);

                DisplayFormat(sender, e, Page);
                Session["FormType"] = 202;
            }
            ImgHint.Visible = true;
            //hdnQID.Value = Session["QuestionID"].ToString();
        }
        protected void Face_Click(object sender, EventArgs e)
        {
            clearCurrentAnswer();
            SetSelected(sender, e);

        }
        protected void Next_Click(object sender, EventArgs e)
        {
            NextStep();
            string s = Session["QUestionID"].ToString() + System.DateTime.Now.ToString();
        }
        protected void Back_Click(object sender, EventArgs e)
        {
            StepBack(Page);
        }
        //protected void Show_Hint(object sender, EventArgs e)
        //{
        //    ShowHint();
        //}
        protected void ibtn_PreRender(object sender, System.EventArgs e)
        {
            checknSelect(sender);
        }
        protected void hint_PreRender(object sender, System.EventArgs e)
        {
            PreHint();
         //   upd.Update();
        }
        protected void Voice_PreRender(object sender, System.EventArgs e)
        {
            //ImageButton ib = (ImageButton)sender;
            //string s = ib.OnClientClick;
            //ib.OnClientClick = s.Replace("()", "(" + Session["Q"].ToString() + ")");

        }
        public string xsx()
        {
            return Session["QuestionID"].ToString() + System.DateTime.Now.ToString();
        }
     }
}