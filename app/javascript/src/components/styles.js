import { makeStyles } from '@material-ui/core/styles';

export const useStyles = makeStyles(() => ({
  navbar__link: {
    textDecoration: 'none',
    color: '#fff',
    fontFamily: 'helvetica'
  },
  navbar__buttonLink: {
    color: '#fff',
    marginRight: '10%',
  },
  navbar__toolbar: {
    justifyContent: 'space-between',
    backgroundColor: '#0e8791'
  },
  navbar__rightToolbar: {
    justifyContent: 'space-between',
    display: 'flex',
    alignItems: 'center',
  },

}));