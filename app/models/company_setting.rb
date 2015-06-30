class CompanySetting < ActiveRecord::Base
  def as_json(options={})
    super(options.merge(
            except: []
          ))
  end
end