## Neighborhood Aid - Backend
In this project, I built an aid platform that connects people in need to willing volunteers in my community.

## Project Brief
Technology can be used in many ways, but it's best used to help people. This can be at the global level, or it can be used to make a difference right outside your door! For example, you may have seen people sleeping in the streets, a single mother struggling to carry a new piece of furniture up the stairs, or someone whose car broke down, so now they can't get to work for a month.

There are so many opportunities to help people; why not build a platform to facilitate exchanged acts of kindness?

In this project, you'll build an aid platform that connects people in need to willing volunteers in your (or any) community.

The project will give you an opportunity to work technically with roles and social connections, as well as with privacy requirements. You will also be sure that your website looks great on mobile devices and tablets.

The behavioral specifications for this project are hefty! Take your time to read through the requirements multiple times and to reflect longer on anything that doesn't make sense at first glance.

### Functionality

### Accounts
A user must be able to sign up. They can create an account with their first name, last name, email address, and an upload button to submit a copy of a government-approved ID (approved formats: .jpg, .png, .pdf).

You do not need to worry about validating that an ID is government-issued or not. You only need to make sure that there is an upload functionality when creating an account and that it accepts the correct file formats.

Volunteering to help
Once signed in, all users see a map (via the Google Maps API with the map geolocalized reasonably to the user's current location) with markers on it indicating people in need of community help.

The markers should be colored differently for two different kinds of needs: one-time tasks (i.e., to help carry a piece of heavy furniture) or for a material need (i.e., a homeless woman on your street who needs a blanket for winter).

The map should be movable and should refresh its results, geolocalized to the new location, if dragged to show a new area.

Think about how on Airbnb, Yelp, or Google Maps will show you different results if you move the search area around. If you need examples, feel free to visit these sites.

Upon clicking a marker, information about the help request appears somewhere on the webpage (you choose where). For each help request, there should be a brief description (300 characters max), a type of request (one-time tasks or material needs, as mentioned above), a location (shown on the displayed map), and a status (fulfilled or unfulfilled, although only unfulfilled requests should be shown on the map). There should also be a button displayed somewhere on the webpage allowing users to volunteer to fulfill the selected need.

Upon clicking the button to fulfill the need, the volunteer is sent into a message flow where they can send a message to the requester directly on the platform. The requester and the volunteer can communicate this way to organize fulfillment of the need.

Once 5 separate users have clicked on the fulfillment button and sent messages to the requester, the need is no longer displayed on the site. This prevents people from putting up requests that last forever to which hundreds of people reply!

What if 1 of the 5 users doesn't actually fulfill the help request, though? If, within 24 hours, the request still hasn't been marked as fulfilled, the requester can republish it. However, if either party marks the request as fulfilled (a status associated with the request that either the requester or volunteer can modify), it cannot be republished.

### Submitting a request
There should also be a button visible on the website allowing users to submit a request for help. You already saw the elements of a request above: there should be a brief description (300 characters max), a type of request (one-time tasks or material needs, as mentioned above), and a location (as a set of latitude and longitude coordinates). There is also a status of fulfilled or unfulfilled associated with the request, although by default, it is unfulfilled.

Each request has multiple parties associated with it: it should have one requester and one-or-more responders.

You can choose the exact terminology to use in your database tables and are not obligated to stick with "requester," for example.

### Counter
There should be a counter for the number of unfulfilled help requests displayed on the homepage. This number should update every few seconds -- without reloading the page.

Are you feeling like you're on specification overload? So many requirements! Get out your pen and paper, and just start drawing some wireframes.

You'll often work on projects where you have a sense of how things should work and what you want. It's harder to see how it all pieces together though. Basic wireframing is an invaluable skill for developers, even if you have designers helping you out on a project. 

You can also diagram in UML to map out your data structures if necessary.

### Technicalities
You'll begin by creating a website the way you're used to doing so at this point: by using Ruby on Rails to get yourself up and running quickly with a robust codebase. Your project must also use React for the front-end. You must also write tests for your code.

You must deploy your website live on the web. How you choose to do so is up to you.

### Mobile and tablets
You should include style rules that take into account mobile and tablet views, consolidating content in a more pleasant way on these screen sizes.