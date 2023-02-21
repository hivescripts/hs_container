import { useNavigate } from 'react-router-dom'
import { useNuiEvent } from '../../hooks/useNuiEvent'
import './index.css'

export default function StartPage() {
    const navigate = useNavigate()

    useNuiEvent<number>('navigate', type => {
        switch(type) {
            case 0:
                navigate('/enter')
                break
            case 1:
                navigate('/reward')
                break
        }
    })

    return (<></>)
}