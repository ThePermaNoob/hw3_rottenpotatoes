# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
	  #puts movie
    Movie.create(movie)
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  #assert_equal page.body.scan(/#{e1}.*#{e2}/).length, 1
  counter = 0
  index1 = page.body.length
  index2 = -1
  page.body.split("<").each do |str|
    if str.include?(e1) && str.include?("td>")
      index1 = counter
    end
    if str.include?(e2) && str.include?("td>")
      index2 = counter
    end
    counter += 1
  end
  assert_operator index2, :>, index1
  #flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(',').each do |rating|
    rating = rating.strip
  	if uncheck
    	step 'I uncheck "ratings_' + rating + '"'
    else
      step 'I check "ratings_' + rating + '"'
    end
  end
end

Then /I should see all the movies/ do
  assert_equal Movie.count, 10
end
