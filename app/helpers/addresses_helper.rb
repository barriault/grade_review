module AddressesHelper
  def address_uin_column(record, column)
    link_to(h(record.uin), "https://howdy.tamu.edu/uPortal/p/TAMU-APP-Launcher.ctf2/detached/render.uP?pCm=view&pP_targetEndpoint=BWXKADDB.p_searchRouter?p_term_in=#{record.term.code}%2526p_last_name_in=%2526p_first_name_in=%2526id_in=#{record.uin}", target: "_blank")
  end
end