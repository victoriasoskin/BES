using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI.DataVisualization.Charting;
using System.Configuration;

namespace WebPWI1
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Error(object sender, EventArgs e)
        {
            writeErrorlog();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!IsPostBack)
            //{
            if (!IsPostBack) SendResults();
            ShowGraph();
            //}
        }
        protected void ShowGraph()
        {
            int gHeight = int.Parse((Request.QueryString["HEIGHT"] == null ? "720" : Request.QueryString["HEIGHT"].ToString()));
            int gWidth = (int)((double)gHeight * 4.0 / 3.0);
            divFrame.Attributes.Add("style", "width: " + gWidth.ToString() + "px; height: " + gHeight.ToString() + "px; position: fixed; top: 50%; left: 50%; margin-top: -" + (gHeight / 2).ToString() + "px; margin-left: -" + (gWidth / 2).ToString() + "px;");

            Chart1.Height = (int)((double)gHeight * 0.84);
            Chart1.Width = gWidth;

            if (Session["FormType"] != null)
                if ((int)Session["FormType"] > 205)
                    Chart1.ChartAreas[0].AxisY.Maximum = 10.0;

            ErrorMsg.Text = "";
            //SET UP THE DATA TO PLOT  
            int[] yVal = new int[10]; // sample data{ 3, 1, 1, 5, 3, 1, 3, 3, 3, 1 };
            string[] yName = { "שמח", "עצוב", "שמח", "עצוב", "שמח", "עצוב", "שמח", "עצוב", "שמח", "עצוב" };
            if (Session["CustomerID"] == null)
            {
                ErrorMsg.Text = " לא זוהה ת.ז. נבדק, המערכת לא תשמור נתוני השאלון";
                ErrorMsg.Visible = true;
                return;
            }

            for (int i = 0; i < 10; i++)
            {
                string sessionKey = string.Format("Test_A{0}", i);
                yVal[i] = (Session[sessionKey] == null ? -1 : (int)Session[sessionKey]);
            }


            string[] xName = { "שביעות רצון כללית", 
                               "רווחה חומרית", 
                               "רווחה פיזית",
                               "התפתחות אישית", 
                               "יחסים בינאישיים עבודה", 
                               "יחסים בינאישיים דירה",
                               "דיור", 
                                "רווחה רגשית", 
                               "הכלה חברתית", 
                               "עתיד"};

            string[] yLabel = { "מאוד שמח", 
                               "שמח", 
                               "לא זה ולא זה",
                               "עצוב", 
                               "מאוד עצוב"
                             };
            string[] color = new string[] { "Blue", "Yellow", "Green", "Red", "LightBlue", "LightBlue", "Gray", "Orchid", "Pink", "Purple" };

            //BIND THE DATA TO THE CHART
            for (int pointIndex = 0; pointIndex < 10; pointIndex++)
            {
                if (yVal[pointIndex] >= 0)
                {
                    Chart1.Series["Series1"].Points.AddXY(xName[pointIndex], yVal[pointIndex]);
                    Chart1.Series["Series1"].Points.Last().Color = System.Drawing.Color.FromName(color[pointIndex]);
                }
            }
            if (Session["FormType"] == null) Response.Redirect("~/CustEventReport.aspx");
            if ((int)Session["FormType"] == 10) Chart1.ChartAreas[0].AxisY.Maximum = 10;
            Chart1.Visible = true;
        }

        protected void SendResults()
        {
            if (Session["CustomerID"] == null)
            {
                ErrorMsg.Text = " לא זוהה ת.ז. נבדק, המערכת לא תשמור נתוני השאלון";
                ErrorMsg.Visible = true;

                return;
            }
            string CustomerIDStr = (string)Session["CustomerID"];
            int CustomerID = -1;
            int.TryParse(CustomerIDStr, out CustomerID);
            if (CustomerID == -1)
            {
                ErrorMsg.Text = " השאלון לא מולא במלואו ולכן לא ישמרו תוצאות";
                ErrorMsg.Visible = true;
                return;
            }
            if (Session["FormType"] == null)
            {
                ErrorMsg.Text = " השאלון לא מולא במלואו ולכן לא ישמרו תוצאות";
                ErrorMsg.Visible = true;

                return;
            }
            int FormTypeID = (int)Session["FormType"];

            int[] Test_Val = new int[10] { -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 };
            for (int i = 0; i < 10; i++)
            {
                string sessionKey = string.Format("Test_A{0}", i);
                Test_Val[i] = (Session[sessionKey] == null ? -1 : (int)Session[sessionKey]);
            }


            try
            {
                string connString = System.Configuration.ConfigurationManager.ConnectionStrings["ExtData"].ConnectionString;
                SqlConnection myConnection = new SqlConnection(connString);
                myConnection.Open();
                string mySQL = "INSERT INTO [ExtData].[dbo].[Survey_Answers] ([CustomerID],[FormTypeID],[QuestionID],[Val],[Loadtime],[EventID]) ";

                DateTime now = System.DateTime.Today;

                int EventID = (int)Session["EventID"];

                for (int i = 0; i < 10; i++)
                {
                    if (Test_Val[i] >= 0)
                    {
                        mySQL = mySQL + String.Format("SELECT {0}, {1}, {2}, {3}, '{4}',{5}", CustomerID, FormTypeID, i, Test_Val[i], now, EventID);
                        mySQL = mySQL + " UNION ALL ";
                    }
                }

                mySQL = mySQL = mySQL.Substring(0, mySQL.Length - " UNION ALL ".Length);

                SqlCommand comm = new SqlCommand(mySQL, myConnection);
                comm.CommandType = CommandType.Text;

                comm.ExecuteNonQuery();
                myConnection.Close();
            }
            catch (Exception excep)
            {
                ErrorMsg.Text = " שליחת תוצאות השאלון לא עברה בהצלחה, אנא פנה לאחראי מחשוב בית אקשטיין";
                ErrorMsg.Visible = true;
                Response.Write("Exception: " + excep.ToString());
                //Console.WriteLine("Exception: " + excep.ToString());
            }
            ErrorMsg.Text = "  תוצאות השאלון נשלחו בהצלחה למאגר בית אקשטיין";
            ErrorMsg.Visible = true;
            ErrorMsg.ForeColor = System.Drawing.ColorTranslator.FromHtml("Green");

        }

        protected void backtoBEonline_Click(object sender, System.EventArgs e)
        {
            Response.Redirect("~/CustEventReport.aspx");
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

    }
}
