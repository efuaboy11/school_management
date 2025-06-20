"use client"
import { faEllipsis } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import React, { use, useContext, useEffect, useState } from 'react'
import Image from 'next/image'
import Link from 'next/link'
import { Pagination, Stack } from '@mui/material';
import AllDataContext from '@/context/AllData'
import AuthContext from '@/context/AuthContext'
import { debounce } from "lodash";
import Select from 'react-select';
import ThemeContext from '@/context/ThemeContext'
import { DownloadLink } from '@/components/downloadLink'

const SchemeOfWorkPage = ({ params }: { params: Promise<any> }) => {
  const param = use(params);
  const [termID, classID,] = param.params || [];

  const { theme, toggleTheme } = useContext(ThemeContext)!
  ;
  const {



    termData,
    TermFunction,
    termQuery,
    setTermQuery,

  
    subjectQuery,
    setSubjectQuery,


  } = useContext(AllDataContext)!;

  const {
    truncateText,
    authTokens,
    formateDateTime,
    formatDate,
    formatName,
    formatCurrency,
    showSidebar,
    loader,
    setLoader,
    disableButton,
    setDisableButton,

    setMessage,
    showAlert,
    setIsSuccess,

  } = useContext(AuthContext)!;

 

  
  
  const [filterOptions, setOptions] = useState(false)


  const [hasMounted, setHasMounted] = useState(false);
  
    useEffect(() => {
      setHasMounted(true);
    }, []);

    

  const toggleFilterOptions = () =>{
    setOptions(!filterOptions)
  }

  const [schemeOfWorkCount, setSchemeOfWorkCount] = useState(0)
  const [schemeOfWorkData, setSchemeOfWorkData] = useState<any[]>([])
  const [schemeOfWorkLoader, setSchemeOfWorkLoader] = useState(true)
  const [schemeOfWorkSearch, setSchemeOfWorkSearch] = useState('')
  
  const [userDetails, setUserDetails] = useState<any>(null)

  const itemsPerPage = 10;
  const [page, setPage] = useState(1);

 console.log('suject', subjectQuery)

  
  const handleChange = (event: React.ChangeEvent<unknown>, value: number) => {
    setPage(value);
  };

  // const schemeOfWorkData = [...Array(100).keys()];
  const startIndex = (page - 1) * itemsPerPage;
  const currentItems = schemeOfWorkData.slice(startIndex, startIndex + itemsPerPage);





  const customStyles = {
    control: (provided: any, state: any) => ({
      ...provided,
      backgroundColor: theme === 'dark' ? '#0d0d0d' : '#fff',
      borderColor: state.isFocused ? '#783ebc' : theme === 'light' ? '#ccc' : '#333',
      boxShadow: state.isFocused ? '0 0 0 4px rgba(120, 62, 188, 0.2)' : 'none',
      color: theme === 'dark' ? '#fff' : '#000',
    }),
  
    menu: (provided: any) => ({
      ...provided,
      backgroundColor: theme === 'dark' ? '#0d0d0d' : '#fff',
      border: '1px solid #ccc',
      zIndex: 999,
    }),
  
    option: (provided: any, state: any) => {
      const isDark = theme === 'dark';
  
      const backgroundColor = state.isSelected
        ? '#783ebc'
        : state.isFocused
        ? isDark
          ? '#1a1a1a' // hover in dark
          : '#f0f0f0' // hover in light
        : isDark
        ? '#0d0d0d'
        : '#fff';
  
      const color = state.isSelected
        ? '#fff'
        : state.isFocused
        ? isDark
          ? '#fff'
          : '#000'
        : isDark
        ? '#fff'
        : '#000';
  
      return {
        ...provided,
        backgroundColor,
        color,
        cursor: 'pointer',
      };
    },
  
    singleValue: (provided: any) => ({
      ...provided,
      color: theme === 'dark' ? '#fff' : '#000',
    }),
  
    placeholder: (provided: any) => ({
      ...provided,
      color: theme === 'dark' ? '#aaa' : '#666',
    }),
  
    input: (provided: any) => ({
      ...provided,
      color: theme === 'dark' ? '#fff' : '#000',
    }),
  
    dropdownIndicator: (provided: any) => ({
      ...provided,
      color: theme === 'dark' ? '#fff' : '#000',
    }),
  
    indicatorSeparator: (provided: any) => ({
      ...provided,
      backgroundColor: theme === 'dark' ? '#444' : '#ccc',
    }),
  };


  



  const SchemeOFWorkFunction = async() =>{
    let response = await fetch(`http://127.0.0.1:8000/api/scheme-of-work/?student_class=${classID}&term=${termID}&subject=${subjectQuery}`, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${authTokens?.access}`
      },
    })

    const data = await response.json()
    console.log(data)
    if(response.ok){
      if(Array.isArray(data) && data.length > 0){
        setSchemeOfWorkCount(data.length)
      }
      
      
      const sortedData = data.sort((a: { id: number }, b: { id: number }) => b.id - a.id);
      setSchemeOfWorkData(sortedData)
      setSchemeOfWorkLoader(false)


    }else{
      setSchemeOfWorkLoader(false)
    }



  }

  const UserDetails = async () =>{
    try{
      let response = await fetch(`http://127.0.0.1:8000/api/students/${authTokens?.user_id}/`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${authTokens?.access}`,
        },

      })
      const data = await response.json()

      if(response.ok){
        setUserDetails(data)
      }
    }catch{
      console.log('error')
    }

  }

 
  useEffect(() =>{
    TermFunction()
    UserDetails()
  }, [])

  useEffect(() =>{
    SchemeOFWorkFunction()
    console.log(schemeOfWorkData)

  }, [subjectQuery])


  return (
    <div className='mb-5 pb-5'>


      <div className="container-xl pt-4">
        <div className="d-md-flex justify-content-between">
          <div>
            <p className="md-text">Scheme of Work</p>
            <p className="light-text pb-3">Total of {schemeOfWorkCount} scheme of work avaliable</p>
         </div>
        </div>

        
        <div className='pt-5'>
          <div className='d-flex'>
            <p className='pe-2 light-text'>Filter</p>
            <label className="site-switch">
              <input type="checkbox" onChange={toggleFilterOptions}/>
              <span className="site-switch-slider"></span>
            </label>

          </div>
          {filterOptions && (
            <div className="d-sm-flex justify-content-start pt-3">
              <div className="d-sm-flex">

                <div className="me-3 mb-3">
                  <label htmlFor="" className='form-label light-text'>Filter by term</label>
                  <select   className={`site-input`}   value={termQuery}  onChange={(e) => setTermQuery(e.target.value)}>
                    <option value="">Select Term</option>
                    {termData.map((data:any) => (
                      <option key={data.id} value={data.id}>{data.name}</option>
                    ))}
                  </select>
                </div>
      
              </div>
            </div>
          )}

        </div>

        <div>
          {schemeOfWorkLoader ? (
            <div>
              <div className="mt-5 pt-5">
                <div className="d-flex justify-content-center align-items-center">
                  <div className="book-loader">
                    <div className="book red"></div>
                    <div className="book blue"></div>
                    <div className="book green"></div>
                  </div>
                </div>
              </div>
            </div>
          ) : (
            <div className='mt-5'>
              {currentItems.length > 0 ? (
                <div>

                  <div className='site-boxes  site-border border-radius-5px dahboard-table non-wrap-text scroll-bar'>
                    <table className='overflow-auto light-text'>
                      <thead className='sm-text'>
                        <tr>
                          <th className='py-2'>Subject</th>
                          <th> Class</th>
                          <th>Term</th>
                          <th>Scheme</th>
                        </tr>
                      </thead>

                      <tbody>
                        {currentItems.length > 0 ? (
                          currentItems.map((data) => (
                            <tr key={data.id}>
                              
                              <td className='py-3'>
                                {formatName(data.subject_name.name)}
                              </td>
                              <td>{formatName(data.student_class_name.name)}</td>
                              <td>{formatName(data.term_name.name)}</td>
                              <td>
                                <DownloadLink
                                  url={data.scheme}
                                  fileName={`${data.subject_name.name}__scheme.pdf`}
                                />
                              </td>

                            </tr>

                          ))

                        ) : (
                          <tr>
                            <td className="py-4">No details available</td>
                          </tr>
                        )}


                      </tbody>

                    </table>

                  </div>

                  {schemeOfWorkData.length > 10 && (
                      <div className="col-12 mb-4 mt-3">
                        <Stack spacing={2} alignItems="end">
                          <Pagination
                            count={Math.ceil(schemeOfWorkData.length / itemsPerPage)}
                            page={page}
                            onChange={handleChange}
                            sx={{
                              '& .MuiPaginationItem-root': {
                                color: '#737b7d', // color of all numbers
                              },
                              '& .MuiPaginationItem-root.Mui-selected': {
                                backgroundColor: '#783ebc', // Your custom color
                                color: '#fff',
                              },
                            }}
                          />
                        </Stack>
                      </div>
                    )}
                </div>

              
              ): (
                <div className="col-12 ">
                  <div className='site-boxes text-center pb-5 d-flex justify-content-center align-items-center  mt-5 pt-5'>
                    <div>
                      <Image src="/img/icon/thinking.png" alt="empty" width={100} height={100} />
                      <p className='light-text md-text'>No details available</p>
                      <p className="light-text">There is no  details right now. Check again later</p>
                    </div>

                  </div>

                </div>
              )}
            </div>
          )}


          
        </div>
      </div>
    </div>
  )
}

export default SchemeOfWorkPage