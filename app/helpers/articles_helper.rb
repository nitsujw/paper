module Merb
  module ArticlesHelper
    def distance_of_time_in_words(from_time, to_time = 0)
      distance_in_minutes = (((to_time - from_time).abs)/60).round
      distance_in_seconds = ((to_time - from_time).abs).round
    
        case distance_in_minutes
          when 0..1
    
            case distance_in_seconds
              when 0..4   then "less than 5 seconds"
              when 5..9   then "less than 10 seconds"
              when 10..19 then "less than 20 seconds"
              when 20..39 then "about 30 seconds ago"
              when 40..59 then "less than 1 minute"
              else             "1 minute"
            end
    
          when 2..44           then "#{distance_in_minutes} minutes ago"
          when 45..89          then "about 1 hour ago"
          when 90..1439        then "about #{(distance_in_minutes.to_f / 60.0).round} hours ago"
          when 1440..2879      then "about 1 day ago"
          when 2880..43199     then "about #{(distance_in_minutes / 1440).round} days ago"
          when 43200..86399    then "about 1 month ago"
          when 86400..525599   then "about #{(distance_in_minutes / 43200).round} months ago"
          when 525600..1051199 then "about 1 year go"
          else                      "over #{(distance_in_minutes / 525600).round} years ago"
      end
    end
      

  end
end # Merb