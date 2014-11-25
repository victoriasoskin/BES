using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TTF.App_Code
{
    public class bpHelber
    { 
        public Int64 CustomerId { get; set; }
        public int UserId { get; set; }
        public int Frm_CatId { get; set; }
        public int CustEventTypeId { get; set; }
        public int EventId { get; set; }
        public int FormId { get; set; }
        public bool CanUpdate { get; set; }
        public DateTime EventDate { get; set; }
        public int FormTypeId { get; set; }
        public int WpId { get; set; }
        public string text { get; set; }

        public global::System.Web.UI.WebControls.ListView lvWP;
        static public List<KeyValuePair<string, string>> wpIndexesColumsctl = new List<KeyValuePair<string, string>>();
        static public List<KeyValuePair<string, string>> wpDetailsColumsctl = new List<KeyValuePair<string, string>>();
        static public List<KeyValuePair<string, string>> wpColumsctl = new List<KeyValuePair<string, string>>();
        static public List<KeyValuePair<string, string>> ctlParam = new List<KeyValuePair<string, string>>();
        static public List<KeyValuePair<string, string>> ddls0Item = new List<KeyValuePair<string, string>>();
        static public List<KeyValuePair<string, string>> ctlOtherTB = new List<KeyValuePair<string, string>>();
        static public List<KeyValuePair<string, string>> ctlSpecial = new List<KeyValuePair<string, string>>();
        static public bool ddlChanged;

        TTF.App_Code.Util u = new TTF.App_Code.Util();
        TTF.App_Code.bpClass bp = new TTF.App_Code.bpClass();
        TTF.App_Code.TT_WP Wp = new TTF.App_Code.TT_WP();
        TTF.App_Code.TT_WP_Indexes Ind = new TTF.App_Code.TT_WP_Indexes();
        TTF.App_Code.TT_WP_Details Det = new TTF.App_Code.TT_WP_Details();
        TTF.App_Code.TT_Header hdr = new TTF.App_Code.TT_Header();
        TTF.App_Code.TT_WP_Reports rep = new TTF.App_Code.TT_WP_Reports();
        Control cRoot;
        public bpHelber(Page page, ListView lvInit)
        {
            cRoot = (Control)page;
            loadCollections(3);
            lvWP = lvInit;
        }

        private void loadCollections(int p)
        {
            if (ctlParam.Count == 0)
            {
                string sql = string.Format("SELECT c.Id,c.Name,k.[Key],k.Value " +
                                        "FROM B10Sec.dbo.TT_Collecions c " +
                                        "LEFT OUTER JOIN B10Sec.dbo.TT_KeyValuePair k ON k.CollectionId=c.Id " +
                                        "WHERE k.FormTypeId={0}", p);
                DataTable dtx = u.selectDBQuesry(sql);
                foreach (DataRow r in dtx.Rows)
                {
                    switch ((string)r["Name"])
                    {
                        case "wpColumsctl":
                            wpColumsctl.Add(new KeyValuePair<string, string>((string)r["Key"], (string)r["Value"]));
                            break;
                        case "wpIndexesColumsctl":
                            wpIndexesColumsctl.Add(new KeyValuePair<string, string>((string)r["Key"], (string)r["Value"]));
                            break;
                        case "wpDetailsColumsctl":
                            wpDetailsColumsctl.Add(new KeyValuePair<string, string>((string)r["Key"], (string)r["Value"]));
                            break;
                        case "ctlParam":
                            ctlParam.Add(new KeyValuePair<string, string>((string)r["Key"], (string)r["Value"]));
                            break;
                        case "ddls0Item":
                            ddls0Item.Add(new KeyValuePair<string, string>((string)r["Key"], (string)r["Value"]));
                            break;
                        case "ctlOtherTB":
                            ctlOtherTB.Add(new KeyValuePair<string, string>((string)r["Key"], (string)r["Value"]));
                            break;
                        case "ctlSpecial":
                            ctlSpecial.Add(new KeyValuePair<string, string>((string)r["Key"], (string)r["Value"]));
                            break;
                    }
                }
                dtx.Dispose();
            }
        }
        public void getHeader(ListView lv)
        {
            lv.DataSource = hdr.getHeader();
            lv.DataBind();
        }

        public void selectAction()
        {
            string sT = HttpContext.Current.Request.Params.Get("__EVENTTARGET");
            string sE = HttpContext.Current.Request.Params.Get("__EVENTARGUMENT");
            if (sT != null && sT.Length > 3 && sT.Substring(0, 3) == "+_+")
            {
                ListViewItem lvi;
                ListView subLv;
                string[] s = sE.Split('|');
                switch (sT)
                {
                    case "+_+Index_Edit":
                        {
                            if (s[0] == "-1")
                                lvi = lvWP.InsertItem;
                            else
                                lvi = lvWP.Items[int.Parse(s[0])];

                            subLv = (ListView)lvi.FindControl("dlIndexes");
                            subLv.EditIndex = int.Parse(s[1]);
                            break;
                        }
                    case "+_+Index_Update":
                        {
                            UpdeteIndexes(sE);
                            break;
                        }
                    case "+_+Details_Insert":
                        {
                            break;
                        }
                    case "+_+Details_Edit":
                        {
                            if (s[0] == "-1")
                                lvi = lvWP.InsertItem;
                            else
                                lvi = lvWP.Items[int.Parse(s[0])];

                            subLv = (ListView)lvi.FindControl("dlDetails");
                            subLv.EditIndex = int.Parse(s[1]);
                            break;
                        }
                    case "+_+Details_Update":
                        {
                            break;
                        }
                    case "+_+Details_Delete":
                        {
                            break;
                        }
                }
            }

        }

        public void SetSelectList(ListViewItem lvi, DropDownList ddl)
        {

            // get ccontrol parameter

            string s = getControlParameter(ctlParam, ddl.ID, lvi);

            // get zero item text

            string sZ = getkplValue(ddls0Item, ddl.ID);

            DataTable dt = bp.getbpClass(s);

            ddl.DataTextField = "Name";
            ddl.DataValueField = "id";
            ddl.Items.Clear();
            ListItem li = new ListItem(sZ, string.Empty);
            ddl.Items.Add(li);

            ddl.DataSource = dt;
            //    ddl.DataBind();
        }

        private string getControlParameter(List<KeyValuePair<string, string>> ctlParam, string ddlId, ListViewItem lvi)
        {
            string s = getkplValue(ctlParam, ddlId);
            if (s.Substring(0, 1) == "_")
            {
                s = s.Substring(1);
            }
            else
            {
                DropDownList ddlp = (DropDownList)lvi.FindControl(s);
                s = (ddlp.SelectedValue == string.Empty ? "NULL" : ddlp.SelectedValue);
            }
            return s;
        }


        public string getkplValue(List<KeyValuePair<string, string>> l, string id)
        {
            foreach (KeyValuePair<string, string> vp in l) if (vp.Key == id) return vp.Value;
            return null;
        }

        public string getkplKey(List<KeyValuePair<string, string>> l, string id)
        {
            foreach (KeyValuePair<string, string> vp in l) if (vp.Value == id) return vp.Key;
            return null;
        }

        public void datasBindCasscadingCtrl(DropDownList ddl, ListViewItem lvi)
        {
            string s = getkplKey(ctlParam, ddl.ID);
            if (s != null)
            {
                ddl = (DropDownList)lvi.FindControl(s);
                ddl.DataBind();
            }

        }

        public void showTextBoxifOther(DropDownList ddl, ListViewItem lvi)
        {
            string s = getkplValue(ctlOtherTB, ddl.ID);
            if (s != null)
            {
                TextBox tb = (TextBox)lvi.FindControl(s);
                if (tb != null)
                {
                    s = ddl.SelectedItem.Text;
                    tb.Visible = s.Length > 5 && s.Substring(s.Length - 5) == "(...)";
                }
            }
        }


        internal void spcialActs(DropDownList ddl, ListViewItem lvi)
        {
            string s = getkplValue(ctlSpecial, ddl.ID);
            switch (s)
            {
                case "SetTarget":

                    break;
            }
        }

        internal void getSupportIndexes(int p, ListView dl)
        {
            int r = 0;
            string s = getkplValue(ctlParam, dl.ID);
            if (s.Substring(0, 1) == "_") r = int.Parse(s.Substring(1));
            DataTable dt = Ind.getIndexes(p, r);
            dl.DataSource = dt;
            //dl.EditIndex = 0;
            dl.DataBind();
        }
        internal void getDetails(int p, ListView dl)
        {
            DataTable dt = Det.getDetails(p);
            dl.DataSource = dt;
            if (!TTF.App_Code.bpHelber.ddlChanged) dl.DataBind();
            //dl.DataBind();
            TTF.App_Code.bpHelber.ddlChanged = false;
        }
        internal void getWp(Int64 p, ListView dl, List<KeyValuePair<string, string>> ctlParam)
        {
            DataTable dt = Wp.getWP(p, 0);
            dl.DataSource = dt;
            dl.DataBind();
        }

        internal void UpdeteIndexes(string sE)
        {

            // If we don't Have FatherRecord - Create One 

            string[] sFields = sE.Split('|');
            int lvIndex = int.Parse(sFields[0]);

            for (int i = 2; i < sFields.Length; i++)
            {
                string[] sVals = sFields[i].Split('=');
                switch (sVals[0])
                {
                    case "IndexId":
                        Ind.IndexId = int.Parse(sVals[1]);
                        break;
                    case "WpId":
                        Ind.WPId = int.Parse(sVals[1]);
                        break;
                    case "val":
                        Ind.val = int.Parse(sVals[1]);
                        break;
                    case "Text":
                        Ind.text = sVals[1].Replace("'", "''");
                        break;
                }
            }


            Ind.WPId = getWpId(lvIndex); // Get WpId // if not found save and get it

            Ind.PeriodKey = System.DateTime.Today.Year * 100 + System.DateTime.Today.Month;
            Ind.FormId = FormId;
            Ind.EventId = EventId;
            Ind.CustomerId = CustomerId;
            Ind.Frm_CatId = Frm_CatId;
            Ind.UserId = UserId;

            ListViewItem lvi;
            if (sFields[0] == "-1")
                lvi = lvWP.InsertItem;
            else
                lvi = lvWP.Items[int.Parse(sFields[0])];

            ListView lv = (ListView)lvi.FindControl("dlIndexes");
            Ind.UpdateRecord();
            lv.EditIndex = -1;
            lv.DataBind();
        }

        private int getWpId(int lvIndex)
        {
            int i = 0;

            if (lvWP != null)
            {
                ListViewItem lvi;
                if (lvIndex < 0) lvi = lvWP.InsertItem; else lvi = lvWP.Items[lvIndex];
                HiddenField hdn = (HiddenField)lvi.FindControl("hdnWpId");
                if (hdn.Value == string.Empty)
                {
                    i = UpdateWp(lvi);
                    hdn.Value = i.ToString();
                }
                else
                {
                    i = int.Parse(hdn.Value);
                    Wp.loadWP(i);
                }
                FormId = Wp.FormId;
                EventId = Wp.EventId;
            }
            return i;
        }

        internal void UpdeteDetails(ListViewItem lvi, int lvIndex)
        {
            Det.WPId = getWpId(lvIndex); // Get WpId // if not found save and get it

            Det.EventId = EventId;
            Det.FormId = FormId;
            Det.CustomerId = CustomerId;

            int Id = 0;
            HiddenField hdn = (HiddenField)lvi.FindControl("hdnId");
            if (hdn != null) Id = (hdn.Value == string.Empty ? 0 : int.Parse(hdn.Value));
            Det.text = getColStrValue("Text", wpDetailsColumsctl, lvi);
            Det.PeriodId = getColIntValue("PeriodId", wpDetailsColumsctl, lvi);
            Det.PeriodText = getColStrValue("PeriodText", wpDetailsColumsctl, lvi);
            Det.AmountId = getColIntValue("AmountId", wpDetailsColumsctl, lvi);
            Det.FrequencyId = getColIntValue("FrequencyId", wpDetailsColumsctl, lvi);
            Det.LengthId = getColIntValue("LengthId", wpDetailsColumsctl, lvi);
            Det.HelperId = getColIntValue("HelperId", wpDetailsColumsctl, lvi);
            Det.HelperText = getColStrValue("HelperText", wpDetailsColumsctl, lvi);

            Det.Frm_CatId = Frm_CatId;
            Det.PeriodKey = System.DateTime.Today.Year * 100 + System.DateTime.Today.Month;
            Det.UserId = UserId;
            bool b = Det.UpdateRecord(Id);
            return;
        }

        internal int UpdateWp(ListViewItem lvi)
        {
            Wp.Frm_CatID = Frm_CatId;
            Wp.CustomerId = CustomerId;

            Wp.RangeId = getColIntValue("RangeId", wpColumsctl, lvi);
            Wp.SubjectId = getColIntValue("SubjectId", wpColumsctl, lvi);
            Wp.PurposeId = getColIntValue("PurposeId", wpColumsctl, lvi);
            Wp.Purpose = getColStrValue("Purpose", wpColumsctl, lvi);
            Wp.TargetId = getColIntValue("TargetId", wpColumsctl, lvi);
            Wp.WeightId = getColIntValue("WeightId", wpColumsctl, lvi);
            EventId = openNewTTPlan();
            Wp.PeriodKey = System.DateTime.Today.Year * 100 + System.DateTime.Today.Month;
            Wp.EventId = EventId;
            Wp.FormId = FormId;
            Wp.UserId = UserId;
            HiddenField hdn = (HiddenField)lvi.FindControl("hdnWpId");
            WpId = (hdn.Value == string.Empty ? 0 : int.Parse(hdn.Value));
            WpId = Wp.UpdateRecord(WpId);
            hdn.Value = WpId.ToString();
            return WpId;
            //ListView lv = (ListView)lvi.NamingContainer;
            //lv.InsertItem.Dispose();
            //lv.DataBind();
        }


        private int getColIntValue(string p, List<KeyValuePair<string, string>> l, ListViewItem lvi)
        {
            string s = getkplValue(l, p);
            DropDownList ddl = (DropDownList)lvi.FindControl(s);
            if (ddl.SelectedValue == null) return 0;
            return int.Parse(ddl.SelectedValue);
        }
        private Int64 getColInt64Value(string p, List<KeyValuePair<string, string>> l, ListViewItem lvi)
        {
            string s = getkplValue(l, p);
            DropDownList ddl = (DropDownList)lvi.FindControl(s);
            if (ddl.SelectedValue == null) return 0;
            return Int64.Parse(ddl.SelectedValue);
        }
        private string getColStrValue(string p, List<KeyValuePair<string, string>> l, ListViewItem lvi)
        {
            string s = getkplValue(l, p);
            TextBox tb = (TextBox)lvi.FindControl(s);
            if (tb.Text == null) return null;
            return tb.Text;
        }
        public bool TTPlanStatus()
        {
            DataTable dt = u.selectDBQuesry("SELECT CustRelateID,CustEventID,CanUpdate,CustEventDate " +
                "FROM Book10.dbo.TT_fnPlanstatus(" + CustomerId.ToString() + "," + UserId.ToString() + "," + Frm_CatId.ToString() + "," + CustEventTypeId.ToString() + "," + EventId.ToString() + ")");
            DataRow r = dt.Rows[0];
            bool b = !r.IsNull("CustEventID") == null;
            if (b)
            {
                FormId = (int)r["FormID"];
                EventId = (int)r["FormID"];
                EventDate = (DateTime)r["CustEventDate"];
            }
            else
            {
                FormId = 0;
                EventId = 0;
            }
            CanUpdate = (bool)r["CanUpdate"];
            dt.Dispose();
            return b;
        }
        public int getCurrentVersion()
        {
            object o = u.selectDBScalar(string.Format("DECLARE @FT nvarchar(50) " +
                                        "SELECT @FT = Name FROM TT_FormTypes WHERE Id = {0} " +
                                        "EXEC TT_pVersionControl {1},{2},{3},@FT,{4}", FormTypeId, CustomerId, Frm_CatId, UserId, CustEventTypeId));
            Int32 i = 0;
            if (o != null) i = (Int32)(o);
            return i;
        }
        public int openNewTTPlan()
        {
            EventId = getCurrentVersion();

            if (EventId == 0)
            {
                string cr = "\n";
                string sql = "DECLARE @D datetime" + cr +
                            "DECLARE @CFrameManager nvarchar(50)" + cr +
                            "DECLARE @CustEventUpdateTypeID int" + cr +
                           "DECLARE @CustEventTypeID int" + cr +
                            "DECLARE @CustEventComment nvarchar(100)" + cr +
                           "SET @D = GETDATE()" + cr +
                            "SET @CustEventUpdateTypeID = 1" + cr +
                             "SELECT @CustEventTypeID = CustEventTypeID,@CustEventComment=Name FROM TT_FormTypes WHERE ID = " + FormTypeId.ToString() + cr +
                            "SELECT @CFrameManager = FrameManager FROM Book10_21.dbo.FrameList WHERE FrameID =" + Frm_CatId.ToString() + cr +
                             "INSERT INTO TT_Forms (FormTypeID,UserID,LoadTime) VALUES(" + FormTypeId.ToString() + "," + UserId.ToString() + ",@D)" + cr +
                            "SELECT ID,@CustEventTypeID as CustEventTypeID,@CFrameManager As FM,@CustEventUpdateTypeID as UT,@D As D,@CustEventComment Comment FROM TT_Forms WHERE Loadtime=@D AND UserID = " + UserId.ToString();
                DataTable dt = u.selectDBQuesry(sql);

                DataRow r = dt.Rows[0];

                EventDate = (DateTime)r["d"];
                FormId = (int)r["Id"];
                string FrameManager = (r.IsNull("FM") ? string.Empty : (string)r["FM"]);
                int ut = (int)r["UT"];
                string comment = r["Comment"].ToString() ;

                sql = string.Format("EXEC Book10_21.dbo.Cust_AddEvent	{0},{1},'{2:yyyy-MM-dd HH:mm:ss}','{3:yyyy-MM-dd}','{10} {4:yyyy-MM}',{5},'{6}',{7},{8},{9}",
                    CustomerId, CustEventTypeId, EventDate, EventDate, EventDate, Frm_CatId, FrameManager, UserId, ut, FormId,comment);

                Exception ex = u.executeSql(sql);

                if (ex == null) EventId = getCurrentVersion();

            }
            else
            {
                FormId = (int)u.selectDBScalar(string.Format("SELECT CustRelateId FROM Book10_21.dbo.CustEventList WHERE CustEventID = {0}", EventId));
            }
            return EventId;
        }
        public string javaParam(ListViewItem lvi, string controlType, string fieldName)
        {
            switch (controlType)
            {
                case "hdn":
                    HiddenField hdn = (HiddenField)lvi.FindControl(controlType + fieldName);
                    if (hdn != null && hdn.Value != null && hdn.Value != string.Empty) return "|" + fieldName + "=" + hdn.Value;
                    break;
                case "tb":
                    break;
            }
            return string.Empty;
        }

        internal void updateReport(ListViewItem lvi)
        {
            rep.Frm_CatId = Frm_CatId;
            rep.CustomerId = CustomerId;

            EventId = openNewTTPlan();
            rep.PeriodKey = System.DateTime.Today.Year * 100 + System.DateTime.Today.Month;
            rep.EventId = EventId;
            rep.FormId = FormId;
            rep.UserId = UserId;

            HiddenField hdn = (HiddenField)lvi.FindControl("hdnWpId");
            WpId = (hdn.Value == string.Empty ? 0 : int.Parse(hdn.Value));
            rep.WPId = WpId;

            string[] ls = { "rbP2", "rbP1", "rb00", "rbM1", "rbM2" };
            int[] ils = { 2, 1, 0, -1, -2 };
            int val = -99;
            for (int i = 0; i < ls.Length; i++)
            {
                RadioButton rb = (RadioButton)lvi.FindControl(ls[i]);
                if (rb.Checked)
                {
                    val = ils[i];
                    rb.Checked = false;
                    break;
                }
            }

            rep.val = val;

            TextBox tb = (TextBox)lvi.FindControl("tbReport");
            text = tb.Text;
            tb.Text = null;
            rep.text = text;

            int Id = rep.UpdateRecord();

        }
    }
}