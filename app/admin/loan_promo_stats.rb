ActiveAdmin.register_page "PromoStats" do
  menu label: '分销推广统计'
  content title: "分销推广统计" do
    # render partial: 'stats'
    
    # 推广活动统计
    columns do
      column do
        panel "推广活动统计" do
          render 'admin/promostats/event_stats'
        end
      end
    end
    
    # 贷款产品统计
    
  end
  
end
