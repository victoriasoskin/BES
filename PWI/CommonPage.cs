using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Media;
using System.Data.SqlClient;
using System.Data;
using System.IO;

namespace WebPWI1
{
    public class CommonPage : System.Web.UI.Page
    {
        public const double MaximumHeight = 720.0;
        public const double MaximumRblFontSize = 30.0;
        public const double FrameRatio = 4.0 / 3.0;
        public const double BackNextRatio = 1.0 / 9.0;
        public const double HintRatio = 1.0 / 6.0;
        public const double HintImgTopRatio = 1.0 / 6.0;
        public const double VoiceRatio = 1.0 / 7.0;
        public const double Pic2MaximumHeight = 300.0;
        public const double Pic3MaximumHeight = 207.0;
        public const double Pic5MaximumHeight = 160.0;
        public const double Pic10MaximumHeight = 78.0;
        public const double Pic2Ratio = Pic2MaximumHeight / MaximumHeight;
        public const double Pic3Ratio = Pic3MaximumHeight / MaximumHeight;
        public const double Pic5Ratio = Pic5MaximumHeight / MaximumHeight;
        public const double Pic10Ratio = Pic10MaximumHeight / MaximumHeight;
        public const double RblFontRatrio = MaximumRblFontSize / MaximumHeight;
        public const double HorizontalPositionAdd = 10.0; //20.0 image border-width*2, 7.0 - width from the table cells 
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
        { get { return (Request.QueryString["HEIGHT"] != null && Request.QueryString["HEIGHT"].Length > 0) ? double.Parse(Request.QueryString["HEIGHT"]) : MaximumHeight; } }
        public string bordr = string.Empty; // "border: dashed 1px black; ";
        public string FrameWidth { get { return (Math.Round(FrameHeight * FrameRatio, 0)).ToString() + "px;"; } }
        public string FrameMarginLeft { get { return Math.Round(-FrameHeight * FrameRatio * 0.5, 0).ToString() + "px;"; } }
        public string FrameMaginTop { get { return Math.Round(-FrameHeight * 0.5, 0).ToString() + "px;"; } }
        public string FrameLeft { get { return "50%;"; } }
        public string FrameTop { get { return "50%;"; } }
        public string divNextBackTop { get { return "30px;"; } }
        public string divNextBackRight { get { return "0px;"; } }
        public int NextBackSize { get { return int.Parse(Math.Round(FrameHeight * BackNextRatio, 0).ToString()); } }
        public int HintHeight { get { return int.Parse(Math.Round(FrameHeight * HintRatio, 0).ToString()); } }
        public int VoiceHeight { get { return int.Parse(Math.Round(FrameHeight * VoiceRatio, 0).ToString()); } }
        public string divQuestionTop { get { return "35%;"; } }
        public string divQuestionRight { get { return "5%;"; } }
        public string divQuestionFontSize { get { return Math.Round(FrameHeight * QuestionFontSizeRatio, 0).ToString() + "px;"; } }
        public string divhintimgTop { get { return Math.Round(FrameHeight * HintImgTopRatio, 0).ToString() + "px;"; } }
        public string RblFontSize { get { return Math.Round(FrameHeight * RblFontRatrio, 0).ToString() + "px;"; } }
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
                case 10:
                    d = FrameHeight * Pic10Ratio;
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
                case 10:
                    d = FrameHeight * Pic10Ratio * 0.5;
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
                case 10:
                    d = ((FrameHeight * Pic10Ratio) + HorizontalPositionAdd) * 10.0 * 0.5;
                    break;
            }
            return Math.Round(-d, 0).ToString() + "px;";
        }
        public string btnHintTop { get { return "25px;"; } }
        public string btnHintLeft { get { return "0px;"; } }
        public string btnVoiceTop { get { return "25px;"; } }
        public string btnVoiceLeft { get { return Math.Round(FrameHeight * VoiceLeftRatio, 0).ToString() + "px;"; } }

        public string divFrameClass { get { return bordr + "width: " + FrameWidth + " height: " + FrameHeight.ToString() + "px; position: fixed; top: " + FrameTop + " left: " + FrameLeft + " margin-top: " + FrameMaginTop + " margin-left: " + FrameMarginLeft; } }
        public string divNextBackClass { get { return bordr + "position: absolute; top: " + divNextBackTop + " right: " + divNextBackRight; } }
        public string btnNextBackClass { get { return bordr + "width: " + NextBackSize + " height: " + NextBackSize; } }
        public string divQuestionClass { get { return bordr + "position: absolute; top: " + divQuestionTop + " right: " + divQuestionRight + " font-size: " + divQuestionFontSize; } }
        public string divHintClass { get { return bordr + "position: absolute; top: " + btnHintTop + " left: " + btnHintLeft; } }
        public string divVoiceClass { get { return bordr + "position: absolute; top: " + btnVoiceTop + " left: " + btnVoiceLeft; } }
        public string divhintimgClass { get { return "position: relative; left: " + divhintimgLeft + " top: " + divhintimgTop + " background-color: #EEEEEE; border: outset 4px #EEEEEE; visibility:hidden;"; } }
        public string litStyleClass(int picNum)
        {
            return "<style type='text/css'>.rbl td  {  background-image:url('rbl.png');background-repeat:no-repeat;background-size:" +
                imageBtnSize(picNum).ToString() + "px;height:" +
                imageBtnSize(picNum).ToString() + "px;width:" +
                imageBtnSize(picNum).ToString() + "px;background-position:right center;padding-left:-10px; } .tb td { border: dashed 1px transparent; }</style>";
        }

        public string tblFacesClass(int picNum)
        {
            return bordr + "position: absolute; top: " + tblFacesTop +
                    " margin-top: " + tblFacesMarginTop(picNum) +
                    " left: " + tblFacesLeft +
                    " margin-left: " +
                    tblFacesMarginLeft(picNum) + (picNum == 10 ? "font-size: " + RblFontSize :string.Empty);
        }

        public static string[] Questions = { null, null, null, null, null, null, null, null, null, null };
        //     "עד כמה אתה מרוצה/שמח מהחיים שלך בזמן האחרון",
        //"עד כמה אתה מרוצה/שמח מהדברים שיש לך? כמו כסף או דברים שלך",
        //"עד כמה אתה מרוצה/שמח ממצב הבריאות שלך",
        //"עד כמה אתה מרוצה/ שמח מהעבודה/ לימודים שלך",
        //"עד כמה אתה מרוצה/ שמח מהקשרים שלך עם אנשים בעבודה / לימודים שלך ",
        //"עד כמה אתה מרוצה/ שמח מהקשרים שלך עם אנשים בדירה שלך",
        //"עד כמה אתה מרוצה מהמקום בו אתה מתגורר היום",
        //"עד כמה אתה מרגיש בטוח  בבית, בעבודה ", 
        //"עד כמה אתה מרוצה/ שמח מפעילויות פנאי כמו חוגים, קניות, בילוי / טיול", 
        //"עד כמה אתה מרוצה/ שמח מהחיים שיהיו לך בעוד שנה"

        //       };
        protected global::System.Web.UI.WebControls.Label QuestionTxt;
        protected global::System.Web.UI.WebControls.Label QID;
        protected global::System.Web.UI.WebControls.Label Feedback;
        protected global::System.Web.UI.WebControls.Literal litStyle;
        protected global::System.Web.UI.WebControls.ImageButton BackClick;
        protected global::System.Web.UI.WebControls.ImageButton NextClick;
        protected global::System.Web.UI.WebControls.ImageButton Voice;
        protected global::System.Web.UI.WebControls.ImageButton Hint;
        protected global::System.Web.UI.WebControls.Image ImgHint;
        protected global::System.Web.UI.WebControls.ImageButton VerySadA1;
        protected global::System.Web.UI.WebControls.ImageButton SadA1;
        protected global::System.Web.UI.WebControls.ImageButton NonoA1;
        protected global::System.Web.UI.WebControls.ImageButton HappyA1;
        protected global::System.Web.UI.WebControls.ImageButton VeryHappyA1;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl divFrame;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl divnextback;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl divQuestion;
        protected global::System.Web.UI.HtmlControls.HtmlTable tblfaces;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl divHint;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl divhintimg;
        protected global::System.Web.UI.HtmlControls.HtmlGenericControl divVoice;
        protected global::System.Web.UI.HtmlControls.HtmlInputHidden hdnQID;
        public string[] imageButtonIds = { string.Empty, "VerySadA1", "SadA1", "NonoA1", "HappyA1", "VeryHappyA1" };
        public CommonPage()
        {
            //if (FrameHeight == 0) FrameHeight = 500;
            base.Load += new EventHandler(CommonPage_Load);
        }

        private void CommonPage_Load(object sender, EventArgs e)
        {
            Session["Q"] = Session["QuestionID"];
            Page p = (Page)sender;
            string s = p.ToString();
            int iFirst = s.ToLower().IndexOf("test") + 4;
            int iLast = s.ToLower().IndexOf("_aspx") - 1;
            s = s.Substring(iFirst, iLast - iFirst + 1);
            int picNum = int.Parse(s);

            if (VerySadA1 != null)
            {
                VerySadA1.BorderColor = System.Drawing.Color.White;
                VerySadA1.Height = imageBtnSize(picNum);
                VerySadA1.Width = imageBtnSize(picNum);
            }
            if (SadA1 != null)
            {
                SadA1.BorderColor = System.Drawing.Color.White;
                SadA1.Height = imageBtnSize(picNum);
                SadA1.Width = imageBtnSize(picNum);
            }
            if (NonoA1 != null)
            {
                NonoA1.BorderColor = System.Drawing.Color.White;
                NonoA1.Height = imageBtnSize(picNum);
                NonoA1.Width = imageBtnSize(picNum);
            }
            if (HappyA1 != null)
            {
                HappyA1.BorderColor = System.Drawing.Color.White;
                HappyA1.Height = imageBtnSize(picNum);
                HappyA1.Width = imageBtnSize(picNum);
            }
            if (VeryHappyA1 != null)
            {
                VeryHappyA1.BorderColor = System.Drawing.Color.White;
                VeryHappyA1.Height = imageBtnSize(picNum);
                VeryHappyA1.Width = imageBtnSize(picNum);
            }

            int QuestionID = 0;
            if (Session["QuestionID"] != null)
                QuestionID = (int)Session["QuestionID"];

            divFrame.Attributes.Add("style", divFrameClass);
            divnextback.Attributes.Add("style", divNextBackClass);
            NextClick.Height = NextBackSize;
            NextClick.Width = NextBackSize;
            BackClick.Height = NextBackSize;
            BackClick.Width = NextBackSize;
            divQuestion.Attributes.Add("style", divQuestionClass);
            divHint.Attributes.Add("style", divHintClass);
            divVoice.Attributes.Add("style", divVoiceClass);
            divhintimg.Attributes.Add("style", divhintimgClass);
            tblfaces.Attributes.Add("style", tblFacesClass(picNum));
            Hint.Height = HintHeight;
            Voice.Height = VoiceHeight;
            ImgHint.Width = HintImgWidth;
            if (litStyle != null) litStyle.Text = litStyleClass(picNum);

            QuestionID++;

            //if (Hint != null)
            //{
            //    Hint.Attributes.Add("onmouseout", "this.src='hint.png';this.style.width='100px'");
            //}
        }
        protected void LoadQestions(int serviceTypeId, int qTypeid)
        {
            int iQId = 0;
            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["ExtData"].ConnectionString;
            SqlConnection myConnection = new SqlConnection(connString);
            SqlCommand comm = new SqlCommand("SELECT QuestionId,Question FROM Survey_Questions WHERE ServiceTypeID = @ServiceTypeID AND QTypeID = @QTypeID", myConnection);
            comm.CommandType = CommandType.Text;
            comm.Parameters.AddWithValue("@ServiceTypeID", serviceTypeId);
            comm.Parameters.AddWithValue("@QTypeID", qTypeid);
            SqlDataReader reader = null;
            try
            {
                myConnection.Open();
                reader = comm.ExecuteReader();
                while (reader.Read())
                {
                    iQId = (int)reader["QuestionId"];
                    Questions[iQId] = (string)reader["Question"];
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                reader.Close();
                myConnection.Close();
            }
        }

        protected void DisplayFormat(object sender, EventArgs e, Page page)
        {
            ClearAllAnswers();
            QuestionTxt.Text = Questions[0];
            QID.Text = "0";
            if (Session["FormType"] == null)
            {
                if (Session["SpeechOrTxt"] == null)
                    return;
                string SpeechOrTxt = (string)Session["SpeechOrTxt"];
                switch (SpeechOrTxt)
                {
                    case "1":
                        Voice.Visible = false;
                        QuestionTxt.Visible = true;
                        break;
                    case "2":
                        Voice.Visible = true;
                        QuestionTxt.Visible = false;
                        break;
                    case "3":
                        Voice.Visible = true;
                        QuestionTxt.Visible = true;
                        break;
                }
            }
        }

        protected void PlayQuestion()
        {
            //string wav = Server.MapPath("PWI/Voice/");
            //int QuestionID = (int)Session["QuestionID"];
            //QuestionID++;
            //wav = wav + String.Format("orig_00{0}.wav", QuestionID);

            //SoundPlayer wavPlayer = new SoundPlayer();
            //wavPlayer.SoundLocation = wav;
            //wavPlayer.Play();
        }

        protected void NextStep()
        {
            if (Session["QuestionID"] == null)
            {
                Feedback.Text = " המערכת לא מצליחה לבנות השאלה הבאה בשאלון. אנא פנה לאחראי מחשוב בית אקשטיין";
                Feedback.Visible = true;
                return;
            }

            if (Session["TempValue"] == null)
            {
                Feedback.Text = " אנא בחר באחד הפרצופים בתשובה לשאלה";
                Feedback.Visible = true;

                return;
            }
            string k = Session["TempValue"].ToString();
            int TempValue =int.Parse(Session["TempValue"].ToString());
            int QuestionID = (int)Session["QuestionID"];

            int NextQ = QuestionID;

            do
            {
                NextQ = NextQ + 1;
            } while (NextQ < Questions.Length && Questions[NextQ] == null);

            string session_key = String.Format("Test_A{0}", QuestionID);
            Session[session_key] = TempValue;
            Session["QuestionID"] = NextQ;
            Session["TempValue"] = null;

            if (NextQ < 10)
            {
                QuestionTxt.Text = Questions[NextQ];
                QID.Text = NextQ.ToString();

                //Hint.Attributes.Remove("onmouseover");
                //Hint.Attributes.Add("onmouseover", "this.src='PWI/Hints/" + String.Format("{0}.jpg", NextQ + 1) + "';this.style.width='250px'");
            }
            else
                Response.Redirect("End.aspx?height=" + FrameHeight.ToString());
        }

        protected void StepBack(Page page)
        {
            if (Session["QuestionID"] == null)
            {
                Feedback.Text = " המערכת לא מצליחה לבנות השאלה הקודמת בשאלון. אנא פנה לאחראי מחשוב בית אקשטיין";
                Feedback.Visible = true;
                return;
            }

            int QuestionID = (int)Session["QuestionID"];

            int NextQ = QuestionID;

            do
            {
                NextQ = NextQ - 1;
            } while (NextQ >= 0 && Questions[NextQ] == null);

            string session_key = String.Format("Test_A{0}", NextQ);
            Session["TempValue"] = Session[session_key];
            Session["QuestionID"] = NextQ;
            //       hdnQID.Value = NextQ.ToString();

            if (NextQ >= 0)
            {
                QuestionTxt.Text = Questions[NextQ];
                QID.Text = NextQ.ToString();
                //Hint.Attributes.Remove("onmouseover");
                //Hint.Attributes.Add("onmouseover", "this.src='PWI/Hints/" + String.Format("{0}.jpg", NextQ + 1) + "';this.style.height = '500px'; z-index = 999;");

                //ImageButton ib = GetImageButton(page, (int)Session["TempValue"]);
                //if (ib != null) SetSelected(ib, null);
            }
            else
            {
                Response.Redirect(string.Format("Default.aspx?ID={0}{1}", Session["CustomerID"], ((int)Session["EventID"] == 0 ? string.Empty : string.Format("&E={0}", Session["EventID"]))));
            }
        }

        protected void ClearAllAnswers()
        {
            for (int i = 0; i <= 9; i++)
            {
                string s = String.Format("Test_A{0}", i);
                Session[s] = null;
            }
            Session["TempValue"] = null;
        }

        protected void ShowHint()
        {
            Response.Write("<script>alert('הצג תמונה כאן');</script>");
            return;
        }
        protected void SetSelected(object sender, EventArgs e)
        {
            ImageButton CurrentFace = (ImageButton)sender;
            CurrentFace.BorderColor = System.Drawing.ColorTranslator.FromHtml("#00B0F0");
            string FaceID = CurrentFace.ID;
            Feedback.Visible = false;
            Feedback.Text = string.Empty;
            switch (FaceID)
            {
                case "VeryHappyA1":
                    Session["TempValue"] = 5;
                    break;
                case "HappyA1":
                    Session["TempValue"] = 4;
                    break;
                case "NonoA1":
                    Session["TempValue"] = 3;
                    break;
                case "SadA1":
                    Session["TempValue"] = 2;
                    break;
                case "VerySadA1":
                    Session["TempValue"] = 1;
                    break;
                default:
                    return;
            }

        }

        protected void clearCurrentAnswer()
        {
            allWhite();
            if(Session["QuestionID"]!=null)
            {
            int i = 0;
                if(int.TryParse(Session["QuestionID"].ToString(),out i))
                {
                    if (i>=0 && i<=9)
                    {
                        string s= String.Format("Test_A{0}", i);
                        Session[s]=null;
                    }
                }
            }
        }

        private bool isLegal(object p, out int i)
        {
            throw new NotImplementedException();
        }
        protected ImageButton GetImageButton(Page page, int ival)
        {
            ImageButton ib = (ImageButton)FindControlRecursive(page, imageButtonIds[ival]);
            return ib;
        }
        private Control FindControlRecursive(Control rootControl, string controlID)
        {
            if (rootControl.ID == controlID) return rootControl;

            foreach (Control controlToSearch in rootControl.Controls)
            {
                Control controlToReturn =
                    FindControlRecursive(controlToSearch, controlID);
                if (controlToReturn != null) return controlToReturn;
            }
            return null;
        }
        protected void checknSelect(object o)
        {
            ImageButton ib = (ImageButton)o;
            string id = ib.ID;
            string session_key = String.Format("Test_A{0}", Session["QuestionID"]);
            if (Session[session_key] != null)
            {
                int i = -1;
                if (int.TryParse(Session[session_key].ToString(), out i))
                {
                    if (i >= 0 && i <= 9)
                    {
                        if (imageButtonIds[i] == id)
                        {
                            Session["TempValue"] = Session[session_key];
                            SetSelected(ib, null);
                        }
                    }
                }
            }

        }
        private void BacktobeOnline(bool cncl)
        {
            Response.Redirect("~/CustEventReport.aspx");
        }
        protected void PreHint()
        {
            bool b = false;
            ImageButton ib = Hint;
            if (divhintimg != null)
            {
                string s = divhintimg.ClientID;
                ib.OnClientClick = "shint('" + s + "'); return false;";
                if (Session["QuestionID"] != null)
                {
                    //Voice.OnClientClick = string.Format("Play({0}",Session["QuestionID"]) + System.DateTime.Now.ToString() + ")";
                    string fn = "PWI/Hints/" + String.Format("{0}.jpg", Session["QuestionID"]);
                    if (File.Exists(Server.MapPath(fn)))
                    {
                        ImgHint.ImageUrl = fn + "?" + System.DateTime.Now.ToString();
                        b = true;
                    }
                }
            }
            ib.Attributes.Add("style", "visibility:" + (b ? "visible" : "hidden"));

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
            SqlCommand cD = new SqlCommand("INSERT INTO Book10.dbo.AA_errLog(ERRTime,UserID,errMessage,Page,SessionID,ComputerName,SourceID,Browser,SpecComment) VALUES(GETDATE()," + "0" + sU + ",'" + sErr.Replace("'", "''") + "','" + s.Replace("'", "''") +
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
                s += "לצערנו, נותקת מהמערכת<br />עליך לחזור ולהתחבר למערכת.<br /><br /><a href='/custeventreport.aspx'>לדף הכניסה למערכת</a></div></body></html>";
            }
            else
            {
                sWeb = string.Empty; //System.Configuration.ConfigurationManager.AppSettings("ReturnToDefault")
                s += "לצערנו ארעה תקלה. <br />התקלה דווחה לצוות המערכת. <br /><br /><br /><a href='/custeventreport.aspx'>בחזרה למערכת</a></div></body></html>";
            }
            HttpContext.Current.Server.ClearError();
            HttpContext.Current.Response.Write(s);

        }
        protected string WhichBrowser()
        {
            string s = string.Empty;
            try
            {
                var x = HttpContext.Current.Request.Browser;
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

            return s;
        }

        protected void allWhite()
        {
            if (VerySadA1 != null)
            {
                VerySadA1.BorderColor = System.Drawing.Color.White;
            }
            if (SadA1 != null)
            {
                SadA1.BorderColor = System.Drawing.Color.White;
            }
            if (NonoA1 != null)
            {
                NonoA1.BorderColor = System.Drawing.Color.White;
            }
            if (HappyA1 != null)
            {
                HappyA1.BorderColor = System.Drawing.Color.White;
            }
            if (VeryHappyA1 != null)
            {
                VeryHappyA1.BorderColor = System.Drawing.Color.White;

            }
        }
    }
}