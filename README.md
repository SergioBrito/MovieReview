# Movie Review App

This document provides instructions the movie review test project

## Application Setup

```
bundle install
rails db:create
rails db:migrate
rails db:seed
```

## Project Goals and Objectives

You are tasked with expanding a basic movie review system. Currently, the project includes a movies view with 10 preloaded movies. Your goal is to implement a feature that allows users to rate each movie across three categories.

### Categories and Rating Scale

Users should rate movies in the following three categories, each on a scale from 1 to 5:

- Performance
- Special Effects
- Storytelling

All categories are equally weighted.

### Functionality Requirements

- Rating Submission:

  Users can submit ratings anonymously, with no need to create or track user accounts.
  Users can submit multiple reviews for the same movie.
- Display Ratings:

  After a review is submitted, display both the individual category scores and the total score.
  The total score should be the equally weighted average of the three categories. For example, if the scores are Performance = 3, Special Effects = 4, and Storytelling = 5, then the Total Score should be 4.
- Additional rating categories:

  In the future, we plan to introduce new rating categories for movies. Your implementation should be designed to easily accommodate the addition of these new categories.
  For now, you do not need to implement the functionality for adding new categories. Just ensure that your current design can support this feature when it becomes necessary.
- Overall rating:

  Display the average rating for each movie based on all submitted reviews. This should include an overall average score as well as the average score for each individual category.

### Time Estimate

This project should take approximately 2-3 hours. Focus primarily on functionality rather than design or usability at this stage.

## Submitting the project

Clone or copy the project to a private repo. Once it is ready you can either share access or zip up the project locally and send it via email to mikewalters@hetalretail.com
