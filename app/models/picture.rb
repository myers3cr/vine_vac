class Picture < ActiveRecord::Base
  belongs_to :location

  has_attached_file :image,
    styles: { thumbnail: "50x50>", small: "100x100>", medium: "300x300>"},
    default_url: "missing-location.png",
    :url  => "/images/:id/:filename/:style"

  do_not_validate_attachment_file_type :image

end
