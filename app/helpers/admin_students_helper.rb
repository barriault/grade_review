module AdminStudentsHelper
  def admin_student_uin_column(record, column)
    link_to(h(record.uin), "https://howdy.tamu.edu/render.UserLayoutRootNode.uP?uP_tparam=utf&utf=%2fcp%2fip%2flogin%3fsys%3dsctssb%26url%3dhttps://compass-ssb.tamu.edu/pls/PROD/BWXKADDB.p_searchRouter?p_term_in=#{record.term.code}%2526p_last_name_in=%2526p_first_name_in=%2526id_in=#{record.uin}", target: "_blank")
  end
end