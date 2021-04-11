import axios from "axios";
import { AUTH_TOKEN } from "../constant";

const instance = () => {
  const stringifyTokenData = localStorage.getItem(AUTH_TOKEN)
  const token_data = !!stringifyTokenData && JSON.parse(stringifyTokenData)
  
  const headers = {
    Authorization:  token_data?.token ? `Bearer ${token_data.token}`: ""
  }

  const axiosCredentials = axios.create({
    headers,
  })

  axiosCredentials.interceptors.response.use(
    (response) => response,
    (error) => {
      throw error
    },
  )
  return axiosCredentials
}

export default instance
