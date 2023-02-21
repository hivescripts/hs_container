import { useNavigate } from 'react-router-dom'
import './index.css'
import { useEffect, useState } from 'react'
import { useNuiEvent } from '../../hooks/useNuiEvent'
import { useVisibility } from '../../providers/VisibilityProvider'
import { fetchNui } from '../../utils/fetchNui'
import { useLanguage } from '../../providers/LanguageProvider'

export default function RewardPage() {
    const navigate = useNavigate()
    const visibility = useVisibility()

    useEffect(() => {
        visibility.setCloseable(true)
    }, [])

    const [vehicleName, setVehicleName] = useState('Mercedes SLS AMG')
    const [vehiclePlate, setVehiclePlate] = useState('XYZ 000')
    
    useNuiEvent<string>('setVehicleName', setVehicleName)
    useNuiEvent<string>('setVehiclePlate', setVehiclePlate)

    const handleClose = () => {
        visibility.setVisible(false)
        fetchNui('hideFrame')
        setTimeout(() => {
            navigate('/')
        }, 100)
    }

    const language = useLanguage()

    return (
        <div className="frame-1 frame-2">
            <div className="title-group">
                <h1 className="title">{language.getString('reward.title')}</h1>
                <p className="glckwunsch-sieh-di">{language.getString('reward.description')}</p>
            </div>
            <div className="reward">
                <div className="frame frame-2"><div className="name">{vehicleName}</div></div>
                <div className="rectangle-1"></div>
                <div className="frame frame-2"><div className="xyz-000">{vehiclePlate}</div></div>
            </div>
            <button className="einlsen" onClick={handleClose}>{language.getString('reward.submit')}</button>
        </div>
    )
}