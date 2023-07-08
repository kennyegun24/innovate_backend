# innovate_backend

### This is meant to be a fusion of already existing real world projects

<br/>

### LANGUAGES AND TECHNOLOGIES USED

| Rank | Languages, Frameworks, and technologies used |
|-----:|---------------|
|     1|           Ruby|
|     2|     PostgreSql|
|     3|  Ruby on Rails|

<br/>

## API ROUTES
### In this backend API, there are 3 different sections/categories on how I sectioned the APIs based on auth state.
<br/>

<!---- Routes for authenticated and unauthenticated users ---->
### GENERAL ROUTES FOR AUTHENTICATED AND UNAUTHENTICATED USERS

<details>
    <summary>
        User Authentication
    </summary>

    a. api/v1/authentication [POST Method]
    {
      user: {
        username: string,
        password: string,
        email: string,
        name: string
      }
    }

    b. api/v1/authentication/login [POST Method]
    {
      password: string,
      email: string,
    }

</details>

<details>
    <summary>
        Other user work experience
    </summary>

    user/:id/experience [GET Method]
</details>

<details>
    <summary>
        Other user followers
    </summary>

    user/:id/followers [GET Method]
</details>

<details>
    <summary>
        Search func
    </summary>

    search?query [GET Method]
</details>

<br/>

<!---- Routes for authenticated users ---->
### ROUTES FOR AUTHENTICATED USERS

<details>
    <summary>
    Posts
    </summary>

    ALL POSTS: /api/v1/auth/posts [GET Method]
    CREATE POST: /api/v1/auth/posts [POST Method]
    ONE POST: /api/v1/auth/posts/:id [GET Method]
    DELETE POST: /api/v1/auth/posts/:id [DESTROY Method]
</details>

<details>
    <summary>
    User Profile
    </summary>

    Update Profile: /api/v1/auth/user/update_profile [PUT Method]
    CURRENT USER PROFILE: /api/v1/auth/user/profile [GET Method]
    OTHR USER PROFILE: /api/v1/auth/users_details/:id [GET Method]
</details>

<details>
    <summary>
    Post interractions
    </summary>

    POST LIKE AND UNLIKE: /api/v1/auth/post/:id/like [POST Method]
    POST CREATE COMMENT: /api/v1/auth/post_comments [POST Method]
    POST DELETE COMMENT: /api/v1/auth/post_comments/:id [DELETE Method]
    POST SHOW ALL COMMENTS: /api/v1/auth/post_comments [GET Method]
</details>

<details>
    <summary>
    Work experience
    </summary>

    CURRENT USER WORK EXPERIENCE: /api/v1/auth/user/:id/experience [GET Method]
    ADD WORK EXPERIENCE: /api/v1/auth/user/experience [POST Method]
    UPDATE WORK EXPERIENCE: /api/v1/auth/user/experience/:id [PUT Method]
</details>

<details>
    <summary>
    Followers
    </summary>

    FOLLOW AND UNFOLLOW USER: /api/v1/auth/follows [POST Method]
    CURRENT USER FOLLOWERS: /api/v1/auth/follows [GET Method]
</details>

<br/>

### ROUTES FOR UNAUTHENTICATED USERS

<details>
    <summary>
        POSTS
    </summary>

    ALL POSTS: /api/v1/unauth/posts [GET Method]
    ONE POST: /api/v1/unauth/posts/:id [GET Method]
    USER POSTS: /api/v1/unauth/user/:id/posts [GET Method]
</details>

<details>
    <summary>
        USER DETAILS
    </summary>

    USER DETAILS: /api/v1/unauth/users_details/:id [GET Method]
</details>

<h1 align="center">Schema Digram</h1>
<!-- ## Schema Diagram -->

## Current schema (will modify diagram with more tables later)
<img src="https://github.com/kennyegun24/innovate_backend/assets/109461921/10a3d492-836f-4098-8153-51a8542b4902"/>
