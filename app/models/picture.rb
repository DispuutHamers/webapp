class Picture < ApplicationRecord
    has_attached_file :avatar, image: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
end
