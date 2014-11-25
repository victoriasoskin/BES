using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace WebPWI1
{
    public partial class _Default : CommonPreTest //System.Web.UI.Page
    {
        protected string CustomerID { get; set; }
        protected string CustomerName { get; set; }
        protected string CustomerBirthDate { get; set; }
        protected string CustomerGender { get; set; }
        protected DateTime LoadTime { get; set; }
        protected int EventID { get; set; }
        public int ServiceTypeID { get; set; }
        protected void Page_Error(object sender, EventArgs e)
        {
            writeErrorlog();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["UserID"] != null)
            //{
            //    if ((int)Session["UserID"] == 823)
            //    {
            //        Response.Write(WhichBrowser());
            //        Response.End();
            //    }
            //}

            if (Request.QueryString["B"] != null) BacktobeOnline(false);
            string sx = string.Empty;
            if (Request.QueryString["height"] == null)
            {
                sx = Request.Url.AbsoluteUri;
                if (sx.ToLower().IndexOf(".aspx?") > 0) sx = sx + "&"; else sx = sx + "?";
                string sScript = "<Script langualge=&quot;javascript&quot;>" +
                    "var h = document.documentElement.clientHeight; " +
                    "var w = document.documentElement.clientWidth; " +
                    "if(h > " + MaximumHeight.ToString() + ") {h = " + MaximumHeight.ToString() + ";} else {if(h < " + MinimumHeight.ToString() + ")  {h = " + MinimumHeight.ToString() + ";}}" +
                    "if(h > " + MinimumHeight.ToString() + ") { if (h * " + FrameRatio.ToString() + " > w) " + 
                    "               {if (w / " + FrameRatio.ToString() + " >= " + MinimumHeight.ToString() + ") " +
                    " { h = Math.round(w / " + FrameRatio.ToString() + "); } else h = " + MinimumHeight.ToString() + "; }}" +
                        " window.open('" + sx + "height=' + h,'_self');</Script>";
                ClientScriptManager cs = Page.ClientScript;
                Type cstype = this.GetType();
                String csname1 = "PopupScript";
                cs.RegisterClientScriptBlock(cstype, csname1, sScript, false);
            }
            else
            {
                int gHeight = int.Parse((Request.QueryString["HEIGHT"] == null ? MaximumHeight.ToString() : Request.QueryString["HEIGHT"].ToString()));
                int gWidth = (int)((double)gHeight * 4.0 / 3.0);
                divFrame.Attributes.Add("style", "width: " + gWidth.ToString() + "px; height: " + gWidth.ToString() + "px; position: fixed; top: 50%; left: 50%; margin-top: -" + (gHeight / 2).ToString() + "px; margin-left: -" + (gWidth / 2).ToString() + "px; overflow: scroll;");



                Session["EventID"] = 0;
                this.LoadTime = System.DateTime.Now;
                bool b = false;
                if (Request.QueryString["id"] != null)
                {
                    this.CustomerID = Request.QueryString["id"];
                    b = true;
                }
                if (Request.QueryString["E"] != null)
                {
                    string E = Request.QueryString["E"];
                    this.EventID = Convert.ToInt32(E);
                    Session["EventID"] = this.EventID;
                    b = true;
                }
                if (b) Button1_Click(sender, e);
            }
        }
        private void BacktobeOnline(bool cncl)
        {
            Response.Redirect("~/CustEventReport.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string FullName = String.Empty;
            string BirthDate = String.Empty;
            string Gender = String.Empty;
            int GenderCode = 0;

            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["ExtData"].ConnectionString;
            SqlConnection myConnection = new SqlConnection(connString);
            SqlCommand comm = new SqlCommand("SELECT FirstName,LastName,Convert(varchar(10), BirthDate, 101)BirthDate,Gender,ServiceTypeHID,ServiceType_H,Range FROM dbo.tf_Customer(@CustomerID,@EventID)", myConnection);
            comm.CommandType = CommandType.Text;
            SqlParameter p_InCustomerID = new SqlParameter("@CustomerID", SqlDbType.Int);
            SqlParameter p_InEventID = new SqlParameter("@EventID", SqlDbType.Int);

            //       Sample valid customerID 39986245;
            if (this.CustomerID == null)
                this.CustomerID = Request.Form["CustomerID"];
            p_InCustomerID.Value = this.CustomerID;
            Session["CustomerID"] = this.CustomerID;

            p_InCustomerID.Direction = ParameterDirection.Input;
            comm.Parameters.Add(p_InCustomerID);
            if (this.EventID == 0)
                p_InEventID.Value = DBNull.Value;
            else
                p_InEventID.Value = this.EventID;
            comm.Parameters.Add(p_InEventID);
            try
            {
                myConnection.Open();
                SqlDataReader reader = comm.ExecuteReader();
                while (reader.Read())
                {
                    FullName = Convert.ToString(reader.GetValue(0)) + ' ' + Convert.ToString(reader.GetValue(1));

                    BirthDate = Convert.ToString(reader.GetValue(2));

                    GenderCode = Convert.ToInt32(reader.GetValue(3));

                    Gender = "זכר";
                    if (GenderCode == 0)
                        Gender = "נקבה";

                    if (Convert.IsDBNull(reader["ServiceTypeHID"]))
                    {
                        Session["ServiceTypeID"] = 1;
                    }
                    else
                    {
                        Session["ServiceTypeID"] = (int)reader["ServiceTypeHID"];
                    }
                    if (!Convert.IsDBNull(reader["ServiceType_H"]))
                    {
                        lblQtype.Text = string.Format("שאלון לתחום {0}", (string)reader["ServiceType_H"]);
                    }

                }
                this.CustomerName = FullName;
                this.CustomerBirthDate = BirthDate;
                this.CustomerGender = Gender;
                this.CustomerID = (string)Session["CustomerID"];
                if (FullName == String.Empty)
                {
                    Session["CustomerID"] = null;
                    ErrorMsg.Text = " ת.ז זו אינה מופיעה במאגר בית אקשטיין \n. נא הזן/י פרטיו ידנית";
                    ErrorMsg.Visible = true;
                }
                else
                {
                    ErrorMsg.Text = string.Empty;
                    ErrorMsg.Visible = false;
                }
                reader.Close();
                myConnection.Close();
            }
            catch (Exception ex)
            {
                throw ex;
                ErrorMsg.Text = " ת.ז זו אינה מופיעה במאגר בית אקשטיין ";
                ErrorMsg.Visible = true;
                Console.WriteLine(ex.ToString());
            }

        }
        protected void Next_Click(object sender, EventArgs e)
        {
            if (Session["CustomerID"] == null)
            {
                ErrorMsg.Text = " נא הזן ת.ז בתחילת השאלון ";
                ErrorMsg.Visible = true;
                return;
            }
            Session["SpeechOrTxt"] = RadioButtonList1.SelectedValue;
            String NextPage = RadioButtonList2.SelectedValue;

            switch (NextPage)
            {
                case "PreTest2.aspx":
                    Session["PreQuestionTxt"] = PreQuestions[0, 0];
                    Session["PreTestType"] = 0;
                    break;
                case "PreTest3.aspx":
                    Session["PreQuestionTxt"] = PreQuestions[1, 0];
                    Session["PreTestType"] = 1;
                    break;
                case "PreTest5.aspx":
                    Session["PreQuestionTxt"] = PreQuestions[2, 0];
                    Session["PreTestType"] = 2;
                    break;
                default:
                    break;
            }
            Session["PreQuestionID"] = 0;
            Session["QuestionTxt"] = "עד כמה אתה שמח עם החיים שלך בזמן האחרון";
            Session["QuestionID"] = 0;

            Save();

            string s = (Request.QueryString["HEIGHT"] != null && Request.QueryString["HEIGHT"].Length > 0 ? double.Parse(Request.QueryString["HEIGHT"]) : double.Parse("720.0")).ToString();
            Response.Redirect(NextPage + "?HEIGHT=" + s);

        }


        protected void Save()
        {
            try
            {
                string connString = System.Configuration.ConfigurationManager.ConnectionStrings["ExtData"].ConnectionString;
                SqlConnection myConnection = new SqlConnection(connString);
                myConnection.Open();
                string mySQL = "INSERT INTO [ExtData].[dbo].[Survey_HAnswers] ([CustomerID],[Val],[Txt],[Loadtime],[EventID]) " +
                            String.Format("SELECT {0}, {1}, N'{2}','{3}',{4}", Session["CustomerID"], DropDownList1.SelectedValue, Request.Form["CustomerMood"], this.LoadTime, this.EventID);

                SqlCommand comm = new SqlCommand(mySQL, myConnection);
                comm.CommandType = CommandType.Text;

                comm.ExecuteNonQuery();
                myConnection.Close();
            }
            catch (Exception excep)
            {
                Console.WriteLine("Exception: " + excep.ToString());
            }
        }
        protected void lblOno_PreRender(object sender, System.EventArgs e)
        {
            Label lbl = (Label)sender;
            if (Request.QueryString["ID"] != null)
            {
                lbl.Visible = false;
            }
            else
            { lbl.Visible = true; }
        }
        protected void btnRetr_PreRender(object sender, System.EventArgs e)
        {
            Button btn = (Button)sender;
            if (Request.QueryString["ID"] != null)
            {
                btn.Visible = false;
            }
            else
            { btn.Visible = true; }
        }
        protected void prsr_PreRender(object sender, System.EventArgs e)
        {
            Label lbl = (Label)sender;

            lbl.Text = WhichBrowser(true);
        }
    }

}

