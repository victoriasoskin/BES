using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace TTF.App_Code
{
    public class TT_WP_Details
    {
        public int id { get; set; }
        public int EventId { get; set; }
        public int FormId { get; set; } 
        public int WPId { get; set; }
        public Int64 CustomerId { get; set; }
        public string text { get; set; }
        public int PeriodId { get; set; }
        public string PeriodText { get; set; }
        public string Period { get; set; }
        public int AmountId { get; set; }
        public string Amount { get; set; }
        public int FrequencyId { get; set; }
        public string Frequency { get; set; }
        public int LengthId { get; set; }
        public string length { get; set; }
        public int HelperId { get; set; }
        public string Helper { get; set; }
        public string HelperText { get; set; }
        public int Ord { get; set; }
        public int Status { get; set; }
        public int Frm_CatId { get; set; }
        public int PeriodKey { get; set; }
        public DateTime LoadTime { get { return System.DateTime.Now; } }
        public int UserId { get; set; }

        Util u;

        public TT_WP_Details()
        {
            u = new Util();
        }

        public DataTable getDetails(int Id)
        {
            SqlConnection cn = u.sqlConn;
            SqlCommand cD = new SqlCommand(string.Format("SELECT Id ,WPId ,Text ,PeriodId ,Period ,PeriodText ,AmountId ,Amount ,FrequencyID ,Frequency ,LengthId ,Length ,HelperId ,Helper,HelperText ,Ord " +
            "FROM TT_vWP_Details " +
                "WHERE WPId={0}", Id), cn);
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cD;
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }
        public bool UpdateRecord(int Id)
        {
            string sql;
            if(Id==0)
            {
            sql = "INSERT INTO Book10.dbo.TT_WP_Details(EventId,FormId,WPId,CustomerId,Text,PeriodId,PeriodText,AmountId,FrequencyID,LengthId,HelperId,HelperText,Ord,Status,Frm_CatID,PeriodKey,LoadTime,UserId) Values(";
            sql += EventId.ToString() + ",";
            sql += FormId.ToString() + ",";
            sql += WPId.ToString() + ",";
            sql += CustomerId.ToString() + ",";
            sql += (text != null && text != string.Empty ? "'" + text.Replace("'", "''") + "'," : "NULL,");
            sql += PeriodId.ToString() + ",";
            sql += (PeriodText != null && PeriodText != string.Empty ? "'" + PeriodText.Replace("'", "''") + "'," : "NULL,");
           sql += AmountId.ToString() + ",";
           sql += FrequencyId.ToString() + ",";
            sql += LengthId.ToString() + ",";
           sql += HelperId.ToString() + ",";
           sql += (HelperText != null && HelperText != string.Empty ? "'" + HelperText.Replace("'", "''") + "',": "NULL,");
           sql += "0,";
            sql += Status.ToString() + ",";
            sql += Frm_CatId.ToString() + ",";
            sql += PeriodKey.ToString() + ",";
            sql += "'" + string.Format("{0:yyyy-MM-yy HH:mm:ss}", LoadTime) + "',";
             sql += UserId.ToString() + ")";
            }
            else
            {
                sql = "UPDATE Book10.dbo.TT_WP_Details SET ";
                sql += "Text=" + (text != null && text != string.Empty ? "'" + text.Replace("'", "''") + "'," : "NULL,");
                sql += "PeriodId=" + PeriodId.ToString() + ",";
                sql += "PeriodText=" + (PeriodText != null && PeriodText != string.Empty ? "'" + PeriodText.Replace("'", "''") + "'," : "NULL,");
                sql += "AmountId=" + AmountId.ToString() + ",";
                sql += "FrequencyId=" + FrequencyId.ToString() + ",";
                sql += "LengthId=" + LengthId.ToString() + ",";
                sql += "HelperId=" + HelperId.ToString() + ",";
                sql += "HelperText=" + (HelperText != null && HelperText != string.Empty ? "'" + HelperText.Replace("'", "''") + "'," : "NULL,");
                sql += "PeriodKey=" + PeriodKey.ToString() + ",";
                sql += "LoadTime='" + string.Format("{0:yyyy-MM-yy HH:mm:ss}", LoadTime) + "',";
                sql += "UserId=" + UserId.ToString() + " ";
                sql += string.Format("WHERE Id={0} ", Id);
            }
             Exception ex = u.executeSql(sql);

             return ex == null;
        }

    }
}