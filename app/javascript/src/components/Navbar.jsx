import React, { useEffect, useState } from 'react'
import { Link, useHistory } from 'react-router-dom';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Typography from '@material-ui/core/Typography';
import IconButton from '@material-ui/core/IconButton';
import AddIcon from '@material-ui/icons/Add';
import { useStyles } from './styles'
import { AUTH_TOKEN } from "../../src/constant";


const Navbar = () => {

  const [isAuthenticated, setIsAuthenticated] = useState(false)
  const history = useHistory()
  
  useEffect(() => {
    checkLoginStatus()
  })

  const classes = useStyles()

  const checkLoginStatus = () => {
  const stringifyTokenData = localStorage.getItem(AUTH_TOKEN)
  const token_data = stringifyTokenData ? JSON.parse(stringifyTokenData) : {}

  const { exp } = token_data

   const isAuthenticated =  exp > Math.floor(new Date().getTime() / 1000)
    setIsAuthenticated(isAuthenticated)
  }

  const handleClick = async () => {
    localStorage.clear()
    history.push('/login');
  }



  return (
      <AppBar position="static">
      <Toolbar className={classes.navbar__toolbar}>
        <Typography variant="h6" className={classes.addTask__title}>
          <Link className={classes.navbar__link} to="/">Clockme</Link>
          </Typography>
          {
            isAuthenticated ? (
            <div className={classes.navbar__rightToolbar}>
              <span><Link to="/login" className={classes.navbar__link} onClick={handleClick}>Logout</Link></span>
            </div>
            ) : null
          }
      </Toolbar>
    </AppBar>
  )
}

export default Navbar;