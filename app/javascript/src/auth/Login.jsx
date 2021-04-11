import React, { useState } from 'react';
import Avatar from '@material-ui/core/Avatar';
import Button from '@material-ui/core/Button';
import CssBaseline from '@material-ui/core/CssBaseline';
import TextField from '@material-ui/core/TextField';
import Link from '@material-ui/core/Link';
import Grid from '@material-ui/core/Grid';
import LockOutlinedIcon from '@material-ui/icons/LockOutlined';
import Typography from '@material-ui/core/Typography';
import Container from '@material-ui/core/Container';
import { useStyles } from './styles'
import { login }  from '../services/apiService'

export default function Login({handleLogin, history}) {

  const [username, setUserName] = useState("")
  const [password, setPassword] = useState("")
  const [error, setError] = useState("")


  const classes = useStyles();

  const handleUserNameChange = (event) => {
    const { value } = event.target
    setUserName(value.trim())
  }

  const handlePasswordChange = (event) => {
    const { value } = event.target
    setPassword(value.trim())
  }

  const handleSubmit = async (event) => {
    event.preventDefault()

    const user = {
      username,
      password
    }

    try {
      const response = await login(user)
      if (response.user) {
        history.push('/')
        setError("")
      }
    }
    catch(err){
      setError(err.response.data.error)
      throw err.response.data
    }
  };

  return (
    <Container component="main" maxWidth="xs">
      <CssBaseline />
      <div className={classes.auth__paper}>
        <Avatar className={classes.auth__avatar}>
          <img src="https://static.intercomassets.com/avatars/4516833/square_128/custom_avatar-1611326961.png?1611326961" alt="" width="32" height="32" />
        </Avatar>
        <Typography component="h1" variant="h5">
          Login
        </Typography>
        <div style={{color: "#ff6eb0", marginTop: '3%'}}>{error}</div>
        <form onSubmit={handleSubmit}  className={classes.auth__form}>
          <TextField
            variant="outlined"
            margin="normal"
            required
            fullWidth
            id="username"
            label="User Name"
            name="username"
            autoComplete="username"
            autoFocus
            value={username}
            onChange={handleUserNameChange}
          />
          <TextField
            variant="outlined"
            margin="normal"
            required
            fullWidth
            name="password"
            label="Password"
            type="password"
            id="password"
            autoComplete="current-password"
            value={password}
            onChange={handlePasswordChange}
          />
          <Button
            type="submit"
            fullWidth
            variant="contained"
            color="primary"
            style={{backgroundColor: '#0e8791'}}
            className={classes.auth__submit}
          >
            Sign In
          </Button>
          <Grid container>
            <Grid item>
              <Link href="/signup" variant="body2" style={{color: '#0e8791'}}>
                {"Don't have an account? Sign Up"}
              </Link>
            </Grid>
          </Grid>
        </form>
      </div>
    </Container>
  );
}