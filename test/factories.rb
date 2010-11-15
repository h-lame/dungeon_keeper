Factory.define :trap do |t|
  t.sequence :name do |n|
    "Trap ##{n}"
  end
  t.base_damage_caused { 20 }
end

Factory.define :dungeon do |d|
  d.sequence :name do |n|
    "Dungeon ##{n}"
  end
  d.levels { 8 }
end

Factory.define :evil_wizard do |ew|
  ew.sequence :name do |n|
    "Evil Wizard ##{n}"
  end
  ew.experience_points { 450 }
  ew.sequence :magic_school do |n|
    EvilWizard::MAGIC_SCHOOLS[n % EvilWizard::MAGIC_SCHOOLS.length]
  end
  ew.association :dungeon
end

Factory.define :dungeon_with_evil_wizard, :parent => :dungeon do |dww|
  dww.after_create { |dww| dww.evil_wizard = Factory.create(:evil_wizard, :dungeon => dww) }
end

Factory.define :trap_installation do |ti|
  ti.association :trap
  ti.association :dungeon
  ti.level { 1 }
  ti.sequence :size do |n|
    TrapInstallation::SIZES[n % TrapInstallation::SIZES.length].dup # duplicate this to avoid it being a "frozen" string
  end
end
