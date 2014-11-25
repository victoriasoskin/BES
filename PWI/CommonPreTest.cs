using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Media;
using System.Data.SqlClient;


namespace WebPWI1
{
    public class CommonPreTest : System.Web.UI.Page

    {

        public const double MaximumHeight = 720.0;
        public const double MinimumHeight = 500.0;
        public const double FrameRatio = 4.0 / 3.0;
        public const double BackNextRatio = 1.0 / 9.0;
        public const double HintRatio = 1.0 / 6.0;
        public const double HintImgTopRatio = 1.0 / 6.0;
        public const double VoiceRatio = 1.0 / 7.0;
        public const double Pic2MaximumHeight = 300.0;
        public const double Pic3MaximumHeight = 207.0;
        public const double Pic5MaximumHeight = 160.0;
        public const double Pic2Ratio = Pic2MaximumHeight / MaximumHeight;
        public const double Pic3Ratio = Pic3MaximumHeight / MaximumHeight;
        public const double Pic5Ratio = Pic5MaximumHeight / MaximumHeight;
        public const double HorizontalPositionAdd = 20.0 + 7.0; //20.0 image border-width*2, 7.0 - width from the table cells 
        public const double QuestionFontSizeRatio = 0.05;
        public const double VoiceLeftRatio = 1.0 / 9.0;
        public const double HintImgWidthRatio = 1.0;

        public double _frameHeight = 0;
        //public double FrameHeight
        //{
        //    get { return 500; }
        //    //get 
        //    //{ return (_frameHeight > MaximumHeight ? MaximumHeight : _frameHeight); }
        //    //set
        //    //{ FrameHeight = value; }
        //}
        public double FrameHeight
        { get { return (Request.QueryString["HEIGHT"] != null && Request.QueryString["HEIGHT"].Length > 0) ? double.Parse(Request.QueryString["HEIGHT"]) : double.Parse("720.0"); } }
        public string bordr = string.Empty; // "border: dashed 1px black; ";
        public string FrameWidth { get { return (Math.Round(FrameHeight * FrameRatio, 0)).ToString() + "px;"; } }
        public string FrameMarginLeft { get { return Math.Round(-FrameHeight * FrameRatio * 0.5, 0).ToString() + "px;"; } }
        public string FrameMaginTop { get { return Math.Round(-FrameHeight * 0.5, 0).ToString() + "px;"; } }
        public string FrameLeft { get { return "50%;"; } }
        public string FrameTop { get { return "50%;"; } }
        public string divNexBackTop { get { return "30px;"; } }
        public string divNexBackRight { get { return "0px;"; } }
        public int NextBackSize { get { return int.Parse(Math.Round(FrameHeight * BackNextRatio, 0).ToString()); } }
        public int HintHeight { get { return int.Parse(Math.Round(FrameHeight * HintRatio, 0).ToString()); } }
        public int VoiceHeight { get { return int.Parse(Math.Round(FrameHeight * VoiceRatio, 0).ToString()); } }
        public string divQuestionTop { get { return "35%;"; } }
        public string divQuestionRight { get { return "5%;"; } }
        public string divQuestionFontSize { get { return Math.Round(FrameHeight * QuestionFontSizeRatio, 0).ToString() + "px;"; } }
        public string divhintimgTop { get { return Math.Round(FrameHeight * HintImgTopRatio, 0).ToString() + "px;"; } }
        public string divhintimgLeft { get { return "0px;"; } }
        public int HintImgWidth { get { return int.Parse(Math.Round(FrameHeight * HintImgWidthRatio, 0).ToString()); } }

        public int imageBtnSize(int PicNum)
        {
            double d = 0;
            switch (PicNum)
            {
                case 2:
                    d = FrameHeight * Pic2Ratio;
                    break;
                case 3:
                    d = FrameHeight * Pic3Ratio;
                    break;
                case 5:
                    d = FrameHeight * Pic5Ratio;
                    break;
            }
            return int.Parse(Math.Round(d, 0).ToString());
        }
        public string tblFacesTop { get { return "68%;"; } }
        public string tblFacesLeft { get { return "50%;"; } }
        public string tblFacesMarginTop(int PicNum)
        {
            double d = 0;
            switch (PicNum)
            {
                case 2:
                    d = FrameHeight * Pic2Ratio * 0.5;
                    break;
                case 3:
                    d = FrameHeight * Pic3Ratio * 0.5;
                    break;
                case 5:
                    d = FrameHeight * Pic5Ratio * 0.5;
                    break;
            }
            return Math.Round(-d, 0).ToString() + "px;";
        }
        public string tblFacesMarginLeft(int PicNum)
        {
            double d = 0;
            switch (PicNum)
            {
                case 2:
                    d = ((FrameHeight * Pic2Ratio) + HorizontalPositionAdd) * 2.0 * 0.5;
                    break;
                case 3:
                    d = ((FrameHeight * Pic3Ratio) + HorizontalPositionAdd) * 3.0 * 0.5;
                    break;
                case 5:
                    d = ((FrameHeight * Pic5Ratio) + HorizontalPositionAdd) * 5.0 * 0.5;
                    break;
            }
            return Math.Round(-d, 0).ToString() + "px;";
        }
        public string btnHintTop { get { return "0px;"; } }
        public string btnHintLeft { get { return "0px;"; } }
        public string btnVoiceTop { get { return "0px;"; } }
        public string btnVoiceLeft { get { return Math.Round(FrameHeight * VoiceLeftRatio, 0).ToString() + "px;"; } }

        public string divFrameClass { get { return bordr + "width: " + FrameWidth + " height: " + FrameHeight.ToString() + "px; position: fixed; top: " + FrameTop + " left: " + FrameLeft + " margin-top: " + FrameMaginTop + " margin-left: " + FrameMarginLeft; } }
        public string divNextBackClass { get { return bordr + "position: absolute; top: " + divNexBackTop + " right: " + divNexBackRight; } }
        public string btnNextBackClass { get { return bordr + "width: " + NextBackSize + " height: " + NextBackSize; } }
        public string divQuestionClass { get { return bordr + "position: absolute; top: " + divQuestionTop + " right: " + divQuestionRight + " font-size: " + divQuestionFontSize; } }
        public string divHintClass { get { return bordr + "position: absolute; top: " + btnHintTop + " left: " + btnHintLeft; } }
        public string divVoiceClass { get { return bordr + "position: absolute; top: " + btnVoiceTop + " left: " + btnVoiceLeft; } }
        public string divhintimgClass { get { return "position: relative; left: " + divhintimgLeft + " top: " + divhintimgTop + " background-color: #EEEEEE; border: outset 4px #EEEEEE; visibility:hidden;"; } }
        public string tblFacesClass(int picNum)
        {
            return bordr + "position: absolute; top: " + tblFacesTop +
                    " margin-top: " + tblFacesMarginTop(picNum) +
                    " left: " + tblFacesLeft +
                    " margin-left: " +
                    tblFacesMarginLeft(picNum);
        }



        public static readonly string[,] PreQuestions = new string[3, 5]
 {
                                                            {
"אם היית מרגיש שמח בנוגע למשהו, על איזה פרצוף היית מצביע",
"אם היית מרגיש עצוב בנוגע למשהו על איזה פרצוף היית מצביע",
"",
"",
""
                                                            },
                                                            {
"אם היית מרגיש שמח בנוגע למשהו, על איזה פרצוף היית מצביע",
"אם היית מרגיש עצוב בנוגע למשהו על איזה פרצוף היית מצביע",
"אם היית מרגיש לא שמח ולא עצוב בנוגע למשהו על איזה פרצוף היית מצביע",
"",
""
                                                            },
                                                            {
"אם היית מרגיש מאוד עצוב בנוגע למשהו, על איזה פרצוף היית מצביע",
"אם היית מרגיש קצת שמח בנוגע למשהו על איזה פרצוף היית מצביע",
"אם היית מרגיש מאוד שמח בנוגע למשהו על איזה פרצוף היית מצביע",
"אם היית מרגיש קצת עצוב בנוגע למשהו על איזה פרצוף היית מצביע",
"אם היית מרגיש לא שמח ולא עצוב בנוגע למשהו על איזה פרצוף היית מצביע"
                                                            }
                                                        };
        public static readonly string[,] PreAnswers = new string[3, 5] {
                                                        {"HappyA1","SadA1","","",""},
                                                        {"HappyB1","SadB1","NonoB1","",""},
                                                        {"VerySadC1","HappyC1","VeryHappyC1","SadC1","NonoC1"}
                                                    };
        public static string[] PreInputAnswers;


        protected global::System.Web.UI.WebControls.Label PreQuestionTxt;
        protected global::System.Web.UI.WebControls.Label Feedback;
        protected global::System.Web.UI.WebControls.ImageButton SadA1;
        protected global::System.Web.UI.WebControls.ImageButton HappyA1;
  

 
        protected global::System.Web.UI.WebControls.ImageButton SadB1;
        protected global::System.Web.UI.WebControls.ImageButton NonoB1;
        protected global::System.Web.UI.WebControls.ImageButton HappyB1;
   
        protected global::System.Web.UI.WebControls.ImageButton VerySadC1;
        protected global::System.Web.UI.WebControls.ImageButton SadC1;
        protected global::System.Web.UI.WebControls.ImageButton NonoC1;
        protected global::System.Web.UI.WebControls.ImageButton HappyC1;
        protected global::System.Web.UI.WebControls.ImageButton VeryHappyC1;

        protected global::System.Web.UI.WebControls.Label QuestionTxt;
        protected global::System.Web.UI.WebControls.Label QID;
        protected global::System.Web.UI.WebControls.ImageButton BackClick;
        protected global::System.Web.UI.WebControls.ImageButton NextClick;
        protected global::System.Web.UI.WebControls.ImageButton Voice;
        protected global::System.Web.UI.WebControls.ImageButton Hint;
        protected global::System.Web.UI.WebControls.Image ImgHint;
        protected global::System.Web.UI.WebControls.ImageButton VerySadA1;
        protected global::System.Web.UI.WebControls.ImageButton NonoA1;
        protected global::System.Web.UI.WebControls.ImageButton VeryHappyA1;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl divFrame;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl divnextback;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl divQuestion;
        protected global::System.Web.UI.HtmlControls.HtmlTable tblfaces;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl divHint;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl divhintimg;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl divVoice;
        protected global::System.Web.UI.HtmlControls.HtmlInputHidden hdnQID;




        public CommonPreTest()
        {
            base.Load += new EventHandler(CommonPreTest_Load);
        }

        private void CommonPreTest_Load(object sender, EventArgs e)
        {
            int picNum = 0;
            Page p = (Page)sender;
            string s = p.ToString();
           
            int iFirst = s.ToLower().IndexOf("test") + 4;
            int iLast = s.ToLower().IndexOf("_aspx") - 1;
            s = s.Substring(iFirst, iLast - iFirst + 1);
            try
            {
                picNum = int.Parse(s);
            }
            catch (Exception ex) {}

            if (VerySadA1 != null)
            {
                VerySadA1.BorderColor = System.Drawing.Color.White;
                VerySadA1.Height = imageBtnSize(picNum);
                VerySadA1.Width = imageBtnSize(picNum);
            }
            if (VerySadC1 != null)
            {
                VerySadC1.BorderColor = System.Drawing.Color.White;
                VerySadC1.Height = imageBtnSize(picNum);
                VerySadC1.Width = imageBtnSize(picNum);
            }
            if (SadA1 != null)
            {
                SadA1.BorderColor = System.Drawing.Color.White;
                SadA1.Height = imageBtnSize(picNum);
                SadA1.Width = imageBtnSize(picNum);
            }
            if (SadB1 != null)
            {
                SadB1.BorderColor = System.Drawing.Color.White;
                SadB1.Height = imageBtnSize(picNum);
                SadB1.Width = imageBtnSize(picNum);
            }
            if (SadC1 != null)
            {
                SadC1.BorderColor = System.Drawing.Color.White;
                SadC1.Height = imageBtnSize(picNum);
                SadC1.Width = imageBtnSize(picNum);
            }
            if (NonoA1 != null)
            {
                NonoA1.BorderColor = System.Drawing.Color.White;
                NonoA1.Height = imageBtnSize(picNum);
                NonoA1.Width = imageBtnSize(picNum);
            }
            if (NonoB1 != null)
            {
                NonoB1.BorderColor = System.Drawing.Color.White;
                NonoB1.Height = imageBtnSize(picNum);
                NonoB1.Width = imageBtnSize(picNum);
            }
            if (NonoC1 != null)
            {
                NonoC1.BorderColor = System.Drawing.Color.White;
                NonoC1.Height = imageBtnSize(picNum);
                NonoC1.Width = imageBtnSize(picNum);
            }
            if (HappyA1 != null)
            {
                HappyA1.BorderColor = System.Drawing.Color.White;
                HappyA1.Height = imageBtnSize(picNum);
                HappyA1.Width = imageBtnSize(picNum);
            }
            if (HappyB1 != null)
            {
                HappyB1.BorderColor = System.Drawing.Color.White;
                HappyB1.Height = imageBtnSize(picNum);
                HappyB1.Width = imageBtnSize(picNum);
            }
            if (HappyC1 != null)
            {
                HappyC1.BorderColor = System.Drawing.Color.White;
                HappyC1.Height = imageBtnSize(picNum);
                HappyC1.Width = imageBtnSize(picNum);
            }
            if (VeryHappyA1 != null)
            {
                VeryHappyA1.BorderColor = System.Drawing.Color.White;
                VeryHappyA1.Height = imageBtnSize(picNum);
                VeryHappyA1.Width = imageBtnSize(picNum);
            }

            if (VeryHappyC1 != null)
            {
                VeryHappyC1.BorderColor = System.Drawing.Color.White;
                VeryHappyC1.Height = imageBtnSize(picNum);
                VeryHappyC1.Width = imageBtnSize(picNum);
            }

            int QuestionID = 0;
            if (Session["QuestionID"] != null)
                QuestionID = (int)Session["QuestionID"];


            //try
            //{
            if (picNum != 0)
            {
               divFrame.Attributes.Add("style", divFrameClass);
                divnextback.Attributes.Add("style", divNextBackClass);
                NextClick.Height = NextBackSize;
                NextClick.Width = NextBackSize;
                BackClick.Height = NextBackSize;
                BackClick.Width = NextBackSize;
                divQuestion.Attributes.Add("style", divQuestionClass);
                tblfaces.Attributes.Add("style", tblFacesClass(picNum));
            }
        }

        

        protected void DisplayFormat(object sender, EventArgs e)
        {
            PreQuestionTxt.Text = (string)Session["PreQuestionTxt"];
            PreInputAnswers = Enumerable.Repeat(string.Empty, 5).ToArray();

        }
        protected void SetSelected(object sender, EventArgs e)
        {
  
           ImageButton CurrentFace = (ImageButton)sender;
           CurrentFace.BorderColor = System.Drawing.ColorTranslator.FromHtml("#00B0F0");
           Session["TempValue"] = CurrentFace.ID;
           Feedback.Visible = false;
        }

        protected int NextStep()
        {
            if (Session["PreQuestionID"] == null)
            {
                Feedback.Text = " המערכת לא מצליחה לבנות השאלה הבאה בשאלון. אנא פנה לאחראי מחשוב בית אקשטיין";
                Feedback.Visible = true;
                return -1;
            }
            if (Session["TempValue"] == null)
            {
                Feedback.Text = " אנא בחר באחד הפרצופים בתשובה לשאלה";
                Feedback.Visible = true;
                return -1;
            }
            return (int)Session["PreQuestionID"];
        }

        public void writeErrorlog()
        {
            Exception ex = HttpContext.Current.Server.GetLastError();
            String sSessID = HttpContext.Current.Session.SessionID;
            string sHostIP = System.Net.Dns.GetHostAddresses(System.Net.Dns.GetHostName()).GetValue(1).ToString();
            string s = HttpContext.Current.Request.Url.AbsoluteUri;
            string sWeb = null;
            string SpecComment = string.Empty;
            string sBrswr = WhichBrowser();
            string sErr = "Undifined Error";
            if (ex != null)
            {
                sErr = ex.ToString();
            }
            string sU = (HttpContext.Current.Session["UserID"] == null ? "0" : HttpContext.Current.Session["UserID"].ToString());



            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["ExtData"].ConnectionString;
            SqlConnection myConnection = new SqlConnection(connString);
            myConnection.Open();
            SqlCommand cD = new SqlCommand("INSERT INTO AA_errLog(ERRTime,UserID,errMessage,Page,SessionID,ComputerName,SourceID,Browser,SpecComment) VALUES(GETDATE()," + "0" + sU + ",'" + sErr.Replace("'", "''") + "','" + s.Replace("'", "''") +
           "','" + sSessID + "','" + sHostIP + "',0,'" + sBrswr + "'," + (SpecComment == string.Empty ? "NULL" : "'" + SpecComment.Replace("'", "''") + "'") + ")", myConnection);
            myConnection.Open();
            try
            {
                cD.ExecuteNonQuery();
            }
            catch (Exception exx)
            {
                throw exx;
            }
            finally
            {
                myConnection.Close();
            }
            s = "<html><head><title></title></head><body style='direction:rtl;'><div style='position:absolute;top:30%;right:40%;height:150px;width:250px;background-color:#DDDDDD;border:2px outset #AAAAAA;text-align:center;'><br />";
            if (sU == "0")
            {
                sWeb = string.Empty; //System.Configuration.ConfigurationManager.AppSettings("ReturnToEntry");
                s += "לצערנו, נותקת מהמערכת<br />עליך לחזור ולהתחבר למערכת.<br /><br /><a href='" + sWeb + "'>לדף הכניסה למערכת</a></div></body></html>";
            }
            else
            {
                sWeb = string.Empty; //System.Configuration.ConfigurationManager.AppSettings("ReturnToDefault")
                s += "לצערנו ארעה תקלה. <br />התקלה דווחה לצוות המערכת. <br /><br /><br /><a href='" + sWeb + "'>בחזרה למערכת</a></div></body></html>";
            }
            HttpContext.Current.Server.ClearError();
            HttpContext.Current.Response.Write(s);

        }
        protected string WhichBrowser(bool b = false)
        {
                    var x = HttpContext.Current.Request.Browser;
            string s = string.Empty;
            if (b)
            {
                s = x.Type;
            }
            else
            {
                try
                {
                    string cr = System.Environment.NewLine;

                    s = "Browser Capabilities" + cr;
                    s += "Type = " + x.Type + cr;
                    s += "Type = " + x.Type + cr;
                    s += "Name = " + x.Browser + cr;
                    s += "Version = " + x.Version + cr;
                    s += "Major Version = " + x.MajorVersion + cr;
                    s += "Minor Version = " + x.MinorVersion + cr;
                    s += "Platform = " + x.Platform + cr;
                    s += "Is Beta = " + x.Beta + cr;
                    s += "Is cr;awler = " + x.Crawler + cr;
                    s += "Is AOL = " + x.AOL + cr;
                    s += "Is Win16 = " + x.Win16 + cr;
                    s += "Is Win32 = " + x.Win32 + cr;
                    s += "Supports Frames = " + x.Frames + cr;
                    s += "Supports Tables = " + x.Tables + cr;
                    s += "Supports Cookies = " + x.Cookies + cr;
                    s += "Supports VBScript = " + x.VBScript + cr;
                    s += "Supports JavaScript = " + x.EcmaScriptVersion.ToString() + cr;
                    s += "Supports ActiveX Controls = " + x.ActiveXControls + cr;
                    s += "Supports JavaScript Version = " + HttpContext.Current.Request.Browser["JavaScriptVersion"] + cr;
                }
                catch (Exception ex)
                {
                }
            }

            return s;
        }

 
    }
}