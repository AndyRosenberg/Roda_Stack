class SnapsController < Roda
  route do |r|
    r.post "toggle" do
      api_only(r)
      # add stuff
    end
  end

  def asset_id(r)
    r.matched_path[/\d+?(?=\/)/, 0]
  end
end