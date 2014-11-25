using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace TTF.App_Code
{
    public class TT_WP_Reports
    {
        public int FormId { get; set; }
        public int EventId { get; set; }
        public Int64 CustomerId { get; set; }
        public int WPId { get; set; }
        public int val { get; set; } 
        public string text { get; set; }
        public int Status { get; set; }
        public int Frm_CatId { get; set; }
        public int PeriodKey { get; set; }
        public DateTime LoadTime { get { return System.DateTime.Now; } }
        public int UserId { get; set; }

        Util u = new Util();

        public DataTable getReports(int Id)
        {
            DataTable dt = u.selectDBQuesry(string.Format("SELECT Id ,FormId ,EventId ,CustomerId ,WpId ,val ,Text ,Status ,Frm_CatId ,PeriodKey ,LoadTime ,r.UserId,u.URName " +
                                                        "FROM Book10.dbo.TT_WP_Reports r " +
                                                        "LEFT OUTER JOIN Book10_21.dbo.p0t_NtB u ON u.UserId=r.UserId " +
                                                        "WHERE WpId = {0} " +
                                                        "ORDER BY LoadTime DESC", Id));
            return dt;
        }


        internal int UpdateRecord()
        {
            string sql = "INSERT INTO Book10.dbo.TT_WP_Reports(FormId,EventId,CustomerId,WpId,val,Text,Status,Frm_CatId,PeriodKey,LoadTime,UserId) VALUES(";
            sql += FormId.ToString() + ",";
            sql += EventId.ToString() + ",";
            sql += CustomerId.ToString() + ",";
            sql += WPId.ToString() + ",";
            sql += val.ToString() + ",";
            sql += (text != null && text != string.Empty ? "'" + text.Replace("'", "''") + "'," : "NULL,");
            sql += Status.ToString() + ",";
            sql += Frm_CatId.ToString() + ",";
            sql += PeriodKey.ToString() + ",";
            sql += "'" + string.Format("{0:yyyy-MM-yy HH:mm:ss}", LoadTime) + "',";
            sql += UserId.ToString() + ")";

            Exception ex = u.executeSql(sql);

            return 0;
        }
    }
}