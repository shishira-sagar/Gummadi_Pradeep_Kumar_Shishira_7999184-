// TASK 1 - JavaScript Basics & Setup

console.log("Welcome to the Community Portal");

window.addEventListener("load", () => {
    alert("Page fully loaded");
});

// TASK 2 - Syntax, Data Types, and Operators

const portalName = "Local Community Portal";
const launchDate = "2026-01-01";
let availableSeats = 50;

console.log(`Portal: ${portalName} | Launch Date: ${launchDate}`);

availableSeats++;
console.log("Updated Seats:", availableSeats);

// TASK 5 - Objects and Prototypes

class EventPortal {
    constructor(id, name, category, location, date, seats) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.location = location;
        this.date = date;
        this.seats = seats;
    }
}

EventPortal.prototype.checkAvailability = function () {
    return this.seats > 0;
};

// GLOBAL STATE 

let events = [];

// TASK 6 - Arrays and Methods

events.push(
    new EventPortal(1, "Music Night", "Music", "City Hall", "2026-12-01", 20),
    new EventPortal(2, "Yoga Workshop", "Workshop", "Park", "2026-11-10", 15),
    new EventPortal(3, "Food Carnival", "Food", "Ground", "2026-10-15", 10)
);

console.log("Music Events:", events.filter(e => e.category === "Music"));
console.log("Formatted:", events.map(e => `Workshop on ${e.name}`));

// TASK 3 - Conditionals, Loops, and Error Handling

function displayValidEvents(list) {
    const today = new Date();

    list.forEach(event => {
        const eventDate = new Date(event.date);

        if (eventDate >= today && event.seats > 0) {
            console.log(`${event.name} is available`);
        } else {
            console.log(`${event.name} is hidden`);
        }
    });
}

function registerForEvent(event) {
    try {
        if (!event || event.seats <= 0) {
            throw new Error("No seats available");
        }

        event.seats--;
        console.log(`Registered for ${event.name}`);

    } catch (err) {
        console.error(err.message);
    }
}

// TASK 4 - Functions, Scope, Closures, HOF

function addEvent(event) {
    events.push(event);
}

function registerUser(eventId) {
    const event = events.find(e => e.id === eventId);

    if (event && event.seats > 0) {
        event.seats--;
        console.log(`User registered for ${event.name}`);
    }
}

function filterEventsByCategory(category, callback) {
    const filtered = events.filter(e => e.category === category);
    callback(filtered);
}

function registrationTracker() {
    let count = 0;

    return function () {
        count++;
        return count;
    };
}

const musicCounter = registrationTracker();

console.log("Registrations:", musicCounter());
console.log("Registrations:", musicCounter());

// TASK 7 - DOM MANIPULATION

let eventContainer;

window.addEventListener("DOMContentLoaded", () => {
    eventContainer = document.querySelector("#eventContainer");
    renderEvents(events);
});

function renderEvents(list) {
    if (!eventContainer) return;

    eventContainer.innerHTML = "";

    list.forEach(event => {
        const card = document.createElement("div");
        card.className = "event-card";

        card.innerHTML = `
            <h3>${event.name}</h3>
            <p>${event.category}</p>
            <p>${event.location}</p>
            <p>${event.date}</p>
            <p>Seats: <span id="seat-${event.id}">${event.seats}</span></p>
            <button onclick="handleRegister(${event.id})">Register</button>
            <button onclick="handleCancel(${event.id})">Cancel</button>
        `;

        eventContainer.appendChild(card);
    });
}

function updateSeatUI(id, seats) {
    const el = document.querySelector(`#seat-${id}`);
    if (el) el.textContent = seats;
}

function handleRegister(id) {
    const event = events.find(e => e.id === id);
    if (event && event.seats > 0) {
        event.seats--;
        updateSeatUI(id, event.seats);
    }
}

function handleCancel(id) {
    const event = events.find(e => e.id === id);
    if (event) {
        event.seats++;
        updateSeatUI(id, event.seats);
    }
}

// TASK 8 - EVENT HANDLING

const categoryFilter = document.querySelector("#categoryFilter");
const searchInput = document.querySelector("#searchInput");

if (categoryFilter) {
    categoryFilter.addEventListener("change", function () {
        if (this.value === "all") {
            renderEvents(events);
        } else {
            renderEvents(events.filter(e => e.category === this.value));
        }
    });
}

if (searchInput) {
    searchInput.addEventListener("input", () => {
        const val = searchInput.value.toLowerCase();
        renderEvents(events.filter(e => e.name.toLowerCase().includes(val)));
    });
}

// TASK 9 - ASYNC JS (FETCH)

async function fetchEvents() {
    try {
        const res = await fetch("events.json");
        const data = await res.json();

        events = data.map(e =>
            new EventPortal(e.id, e.name, e.category, e.location, e.date, e.seats)
        );

        if (events.length > 0) {
    console.log("Object.entries check:", Object.entries(events[0]));
}

        renderEvents(events);
        populateDropdown(events);

    } catch (err) {
        console.error("Fetch error:", err);
    }
}
window.addEventListener("DOMContentLoaded", fetchEvents);

// TASK 10 - MODERN JS FEATURES

function createEvent(name = "Default Event", category = "General") {
    return { name, category };
}

const sample = {
    id: 10,
    name: "Dance Night",
    category: "Music",
    location: "Arena",
    date: "2026-06-20",
    seats: 10
};

const { name, category, location } = sample;

console.log(name, category, location);

const clonedEvents = [...events].filter(e => e.seats > 0);

// TASK 11 - FORMS

const form = document.querySelector("#registrationForm");

function populateDropdown(list) {
    if (!form) return;

    const dropdown = form.elements["selectedEvent"];
    dropdown.innerHTML = `<option value="">Select Event</option>`;

    list.forEach(e => {
        const option = document.createElement("option");
        option.value = e.id;
        option.textContent = e.name;
        dropdown.appendChild(option);
    });
}

if (form) {
    form.addEventListener("submit", (e) => {
        e.preventDefault();

        const username = form.elements["username"]?.value.trim() || "";
        const email = form.elements["email"]?.value.trim() || "";
        const eventId = form.elements["selectedEvent"].value;

        if (!username || !email || !eventId) {
            alert("Please fill all fields");
            return;
        }

        sendRegistration({ username, email, eventId });
    });
}

// TASK 12 - FETCH POST

function sendRegistration(data) {
    fetch("https://jsonplaceholder.typicode.com/posts", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(data)
    })
    .then(res => res.json())
    .then(res => {
        console.log("Success:", res);
        alert("Registration Successful");
    })
    .catch(err => {
        console.error(err);
        alert("Registration Failed");
    });
}

// TASK 13 - DEBUGGING

function debug(data) {
    console.log("Debug Start:", data);

    if (!data.username) {
        console.error("Missing username");
    }
}

// TASK 14 - jQuery (SAFE VERSION)

if (window.jQuery) {
    $(document).ready(function () {
        $("#registerBtn").click(() => {
            console.log("Register button clicked");
        });

        setTimeout(() => {
            $(".event-card").hide().fadeIn(500);
        }, 300);
    });
}

/*
Framework Benefit:
React/Vue provide component-based architecture,
state management, reusable UI, and faster rendering using virtual DOM.
*/