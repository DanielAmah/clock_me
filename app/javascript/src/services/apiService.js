import instance from '../utils/apiClient'
import { AUTH_TOKEN, IS_ADMIN } from "../constant";



export const login = async (user) => {
  const axios = instance()
  const {data} = await axios.post('/login', { user })
  const {token_data, is_admin } = data
  if(token_data){
    localStorage.setItem(IS_ADMIN, JSON.stringify(is_admin))
    localStorage.setItem(AUTH_TOKEN, JSON.stringify(token_data))
  }
  return data
}

export const createUser = async (user) => {
  const axios = instance()
  const {data} = await axios.post('/users', { user })
  return data
}


export const getProfessions = async () => {
  const axios = instance()
  const { data } = await axios.get('/professions')
  return data
}

export const getUserEvents = async () => {
  const axios = instance()
  const { data } = await axios.get('/user_events')
  return data
}

export const createNewEvent = async (eventData) => {
  const axios = instance()
  const {data} = await axios.post('/events', { event: eventData })
  return data
}

export const clockOut = async (eventId) => {
  const axios = instance()
  const {data} = await axios.put(`/events/${eventId}/clock_out`)
  return data
}

export const editEvent = async (eventId, eventData) => {
  const axios = instance()
  const {data} = await axios.put(`/events/${eventId}`, {event: eventData})
  return data
}

export const trashEvent = async (eventId) => {
  const axios = instance()
  const { data } = await axios.put(`/events/${eventId}/trash_event`)
  return data
}