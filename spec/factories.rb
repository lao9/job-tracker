FactoryGirl.define do

  factory :contact do
    company
    name Faker::TwinPeaks.character
    position Faker::Company.profession.capitalize
    email Faker::Internet.email
  end

  factory :comment do
    body Faker::RuPaul.quote
    job
  end

  factory :job do
    company
    category
    title Faker::Company.profession.capitalize
    description Faker::Company.bs
    city Faker::Address.city
    sequence :level_of_interest do
      rand(1..20)
    end
  end

  factory :company do
    sequence :name do |n|
      Faker::Company.name + " #{n}"
    end
  end

  factory :category do
    sequence :title do |n|
      Faker::Company.buzzword + " #{n}"
    end
  end
end
