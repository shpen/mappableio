module ApplicationHelper
  def build_markers(users)
    markers = Gmaps4rails.build_markers(users) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow AutoHtml::auto_html(user.message) { simple_format; link(:target => 'blank') }
    end

    markers
  end
end
