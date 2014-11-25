using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace TTF.App_Code
{
    public class TT_WP_Indexes
    {
        public int Id { get; set; }
        public int FormId { get; set; }
        public int EventId { get; set; }
        public int IndexId { get; set; } 
        public int WPId { get; set; }
        public string text { get; set; }
        public int val { get; set; }
        public int Status { get; set; }
        public Int64 CustomerId { get; set; }
        public int Frm_CatId { get; set; }
        public int PeriodKey { get; set; }
        public DateTime LoadTime { get { return System.DateTime.Now; } }
        public int UserId { get; set; }

        Util u;

        public TT_WP_Indexes()
        {
            u = new Util();
        }

        public DataTable getIndexes(int Id, int root)
        {
            string sql;
            SqlConnection cn = u.sqlConn;
            sql = string.Format("SELECT i.Id ,ISNULL(i.IndexId,c.Id) IndexId,c.Name ,WPId ,i.Text ,c.Val " +
                "FROM B10Sec.dbo.TT_Classes c " +
                "LEFT OUTER JOIN (SELECT * FROM TT_WP_Indexes WHERE WPId={0}) i ON c.Id=i.IndexId " +
                "WHERE Parent={1}", Id, root);
            SqlCommand cD = new SqlCommand(sql, cn);
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cD;
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }
        internal bool UpdateRecord()
        {
            string sql = string.Format("IF EXISTS(SELECT * FROM Book10.dbo.TT_WP_Indexes WHERE WpId={0} AND IndexId={1})", WPId, IndexId);

            sql += "UPDATE Book10.dbo.TT_WP_Indexes SET ";
            if (text != null && text != string.Empty) sql += "Text='" + text.Replace("'", "''") + "',";
            sql += "PeriodKey=" + PeriodKey.ToString()+ ",";
            sql += "LoadTime='" + string.Format("{0:yyyy-MM-yy HH:mm:ss}", LoadTime) + "',";
            sql += "UserId=" + UserId.ToString() + " ";
            sql += string.Format("WHERE WpId={0} AND IndexId={1} ", WPId, IndexId);
 
            sql += "ELSE ";
  
            sql += "INSERT INTO Book10.dbo.TT_WP_Indexes(FormID,EventID,IndexId,WPId,Text,Val,Status,CustomerId,Frm_CatId,PeriodKey,LoadTime,UserId) VALUES(";
            sql += FormId.ToString() + ",";
            sql += EventId.ToString() + ",";
            sql += IndexId.ToString() + ",";
            sql += WPId.ToString() + ",";
            sql += (text == string.Empty ? "NULL," : "'" + text.Replace("'", "''") + "',");
            sql += val.ToString() + ",";
            sql += Status.ToString() + ",";
            sql += CustomerId.ToString() + ",";
            sql += Frm_CatId.ToString() + ",";
            sql += PeriodKey.ToString() + ",";
            sql += "'" + string.Format("{0:yyyy-MM-yy HH:mm:ss}", LoadTime) + "',";
            sql += UserId.ToString() + ")";

            Exception ex = u.executeSql(sql);
            return ex == null;
        }

    }
}
