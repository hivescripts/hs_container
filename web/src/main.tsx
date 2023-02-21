import React from 'react'
import ReactDOM from 'react-dom/client'
import "inter-ui/inter.css";
import './index.css'
import { VisibilityProvider } from './providers/VisibilityProvider'
import { createHashRouter, RouterProvider } from 'react-router-dom'
import EnterCodePage from './pages/enter/enterCode'
import ChoosePage from './pages/choose/choose'
import OpenPage from './pages/open/open'
import RewardPage from './pages/reward/reward'
import StartPage from './pages/start/start'
import { LanguageProvider } from './providers/LanguageProvider';

const router = createHashRouter([
    {
        path: '/',
        element: <StartPage />,
    },
    {
        path: '/enter',
        element: <EnterCodePage />,
    },
    {
        path: '/choose',
        element: <ChoosePage />,
    },
    {
        path: '/open',
        element: <OpenPage />,
    },
    {
        path: '/reward',
        element: <RewardPage />,
    }
])

ReactDOM.createRoot(document.getElementById('root') as HTMLElement).render(
    <React.StrictMode>
        <LanguageProvider>
            <VisibilityProvider>
                <RouterProvider router={router} />
            </VisibilityProvider>
        </LanguageProvider>
    </React.StrictMode>
)