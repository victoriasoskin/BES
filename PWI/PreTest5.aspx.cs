using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebPWI1
{
    public partial class PreTest5 : CommonPreTest
    {
        protected void Page_Error(object sender, EventArgs e)
        {
            writeErrorlog();
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DisplayFormat(sender, e);
            }
        }

        protected void Face_Click(object sender, EventArgs e)
        {
            SetSelected(sender, e);
         }
        protected void Next_Click(object sender, EventArgs e)
        {
            int i;
            int PreQuestionID = NextStep();
            if (PreQuestionID == -1)
                return;
            PreInputAnswers[PreQuestionID] = (string)Session["TempValue"];
            int NextQ = PreQuestionID + 1;
            int PreTestType = (int)Session["PreTestType"];

            if (NextQ < 5 && PreQuestions[PreTestType, NextQ] != "")
            {
                Session["PreQuestionID"] = NextQ;
                PreQuestionTxt.Text = PreQuestions[PreTestType, NextQ];
                Session["TempValue"] = null;
            }
            else
            {
                //Conclude
                for (i = 0; i < 5; i++)
                {
                    if (PreAnswers[PreTestType, i] != PreInputAnswers[i])
                    {
                        if (Session["TestCounter"] == null)
                            Session["TestCounter"] = 1;
                        else
                            Session["TestCounter"] = 2;

                        Session["PreTest_A_Result"] = "נסה שנית";
                        if ((int)Session["TestCounter"] == 1)
                            Session["NextAction"] = "ערוך את המבחן המקדים שוב";
                        else
                        {
                            Session["NextAction"] = "מבחן 3 פרצופים";
                            Session["PreTest_A_Result"] = "";
                        }
                        break;
                    }
                }
                if (i == 5)
                {
                    Session["PreTest_A_Result"] = "יפה מאוד";
                    Session["NextAction"] = "עבור למבחן";
                }
                string NextAction = (string)Session["NextAction"];
                switch (NextAction)
                {
                    case "עבור למבחן":
                        Session["NextAction"] = "";
                        Session["QuestionTxt"] = "עד כמה אתה שמח עם החיים שלך בזמן האחרון";
                        Session["QuestionID"] = 0;
                        Response.Redirect("Test5.aspx?HEIGHT=" + FrameHeight.ToString());
                        break;
                    case "ערוך את המבחן המקדים שוב":
                        Session["NextAction"] = "";
                        Session["PreQuestionID"] = 0;
                        Session["PreQuestionTxt"] = PreQuestions[1, 0];
                        PreInputAnswers = Enumerable.Repeat(string.Empty, 5).ToArray();

                        Response.Redirect("Test3.aspx?HEIGHT=" + FrameHeight.ToString());
                        break;
                    case "מבחן 3 פרצופים":
                        Session["QuestionTxt"] = "עד כמה אתה שמח עם החיים שלך בזמן האחרון";
                        Session["QuestionID"] = 0;
                        Response.Redirect("Test3.aspx?HEIGHT=" + FrameHeight.ToString());
                        break;
                    default:
                        return;
                }
            }
        }
    }
}